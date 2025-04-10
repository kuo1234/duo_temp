import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
import 'package:zhi_duo_duo/core/models/student.dart';
import 'package:zhi_duo_duo/core/services/api_service.dart';
import 'package:zhi_duo_duo/core/services/auth_service.dart';
import 'package:zhi_duo_duo/viewmodels/base_view_model.dart';

class StudentViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();

  // Add controllers for all text fields
  final studentNameController = TextEditingController();
  final parentNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final teacherTraitsController = TextEditingController();
  final passwordController = TextEditingController();
  final verificationCodeController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  DateTime selectedDate = DateTime.now();
  String selectedGender = '男';
  String selectedProficiencyLevel = '初學者';
  String selectedLearningMode = '線上';
  String selectedCourseType = '一對一';
  double courseDurationHours = 2.0; // 每次課程的時數
  String courseDurationUnit = '小時/堂'; // 單位提示
  int lessonFrequency = 1; // 每週上幾次課
  RangeValues priceRangeValues = RangeValues(300, 700);
  List<String> selectedInterests = [];
  List<String> selectedSubjects = [];
  List<Map<String, dynamic>> availableDaysList = [];
  File? profileImageFile;
  String? profileImageBase64; // Store base64 encoded image
  Uint8List? profileImageBytes; // For displaying the image
  double minimumRating = 3.0; // Default minimum rating value

  // 手機驗證相關屬性
  String? _verificationId; // 儲存 Firebase 手機驗證的 verificationId
  String? get verificationId => _verificationId;

  // 興趣和科目選項
  final List<String> interestOptions = [
    '繪畫',
    '鋼琴',
    '科學',
    '運動',
    '閱讀',
    '舞蹈',
    '程式設計',
  ];
  final List<String> subjectOptions = [
    '英文',
    '數學',
    '自然',
    '社會',
    '音樂',
    '美術',
    '脫口秀',
    'Python 程式設計',
  ];
  final List<String> weekdays = ['週一', '週二', '週三', '週四', '週五', '週六', '週日'];

  final AuthService _authService = AuthService();
  final ApiService _apiService = ApiService();

  Student? _student;
  Student? get student => _student;

  StudentViewModel() {
    // Initialize the student object
    _student = Student(
      studentName: '',
      parentName: '',
      birthDate: DateTime.now(),
      gender: selectedGender,
      profilePicture: '',
      interests: [],
      parentEmail: '',
      parentPhone: '',
      preferredTeacherTraits: '',
      subjects: [],
      proficiencyLevel: selectedProficiencyLevel,
      availableDays: [],
      learningMode: selectedLearningMode,
      courseType: selectedCourseType,
      courseDuration: {
        'hours': courseDurationHours,
        'unit': courseDurationUnit,
      },
      lessonFrequency: lessonFrequency, // 新增
      priceRange: {'min': priceRangeValues.start, 'max': priceRangeValues.end},
      ratings: 0.0,
      account: '',
      password: '',
      verificationCode: '',
      verificationMethod: 'Email',
    );
  }

  @override
  void dispose() {
    studentNameController.dispose();
    parentNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    teacherTraitsController.dispose();
    passwordController.dispose();
    verificationCodeController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800, // Resize image to save memory and bandwidth
      maxHeight: 800,
      imageQuality: 85, // Compress image slightly for better performance
    );

    if (image != null) {
      try {
        // Read image as bytes
        final bytes = await image.readAsBytes();

        // Convert to base64
        profileImageBase64 = base64Encode(bytes);
        profileImageBytes = bytes; // Store bytes for display

        if (!kIsWeb) {
          profileImageFile = File(
            image.path,
          ); // Keep file reference for non-web
        }

        // Update student model with base64 image
        updateStudentInfo('profilePicture', profileImageBase64);
        notifyListeners();
      } catch (e) {
        print('Error processing image: $e');
      }
    }
  }

  void selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      updateStudentInfo('birthDate', selectedDate);
      notifyListeners();
    }
  }

  void toggleInterest(String interest) {
    if (selectedInterests.contains(interest)) {
      selectedInterests.remove(interest);
    } else {
      selectedInterests.add(interest);
    }
    updateStudentInfo('interests', selectedInterests);
    notifyListeners();
  }

  void toggleSubject(String subject) {
    if (selectedSubjects.contains(subject)) {
      selectedSubjects.remove(subject);
    } else {
      selectedSubjects.add(subject);
    }
    updateStudentInfo('subjects', selectedSubjects);
    notifyListeners();
  }

  void updateLessonFrequency(int frequency) {
    lessonFrequency = frequency;
    updateStudentInfo('lessonFrequency', lessonFrequency);
    notifyListeners();
  }

  void addavailableDays(String day, String startTime, String endTime) {
    availableDaysList.add({
      'day': day,
      'startTime': startTime,
      'endTime': endTime,
    });
    updateStudentInfo('availableDays', availableDaysList);
    notifyListeners();
  }

  void removeavailableDays(int index) {
    if (index >= 0 && index < availableDaysList.length) {
      availableDaysList.removeAt(index);
      updateStudentInfo('availableDays', availableDaysList);
      notifyListeners();
    }
  }

  void updatePriceRange(RangeValues values) {
    priceRangeValues = values;
    final priceRange = {'min': values.start, 'max': values.end};
    updateStudentInfo('priceRange', priceRange);
    notifyListeners();
  }

  void registerStudent(Student student) {
    _student = student;
    notifyListeners();
  }

  void updateCourseDuration(double hours, String unit) {
    courseDurationHours = hours;
    courseDurationUnit = unit;
    updateStudentInfo('courseDuration', {
      'hours': courseDurationHours,
      'unit': courseDurationUnit,
    });
    notifyListeners();
  }

  void updateMinimumRating(double rating) {
    minimumRating = rating;
    updateStudentInfo('ratings', rating);
    notifyListeners();
  }

  void updateStudentInfo(String key, dynamic value) {
    if (_student == null) {
      _student = Student(
        studentName: '',
        parentName: '',
        birthDate: DateTime.now(),
        gender: '',
        profilePicture: '',
        interests: [],
        parentEmail: '',
        parentPhone: '',
        preferredTeacherTraits: '',
        subjects: [],
        proficiencyLevel: '',
        availableDays: [],
        learningMode: '',
        courseType: '',
        courseDuration: {'hours': 2.0, 'unit': '小時/堂'},
        lessonFrequency: 1, // 預設值
        priceRange: {'min': 300.0, 'max': 700.0},
        ratings: 0.0,
        account: '',
        password: '',
        verificationCode: '',
        verificationMethod: '',
      );
    }

    switch (key) {
      case 'studentName':
        _student!.studentName = value ?? '';
        studentNameController.text = value ?? '';
        break;
      case 'parentName':
        _student!.parentName = value ?? '';
        parentNameController.text = value ?? '';
        break;
      case 'birthDate':
        _student!.birthDate = value ?? DateTime.now();
        break;
      case 'gender':
        _student!.gender = value ?? '';
        break;
      case 'profilePicture':
        _student!.profilePicture = value ?? '';
        break;
      case 'interests':
        _student!.interests = List<String>.from(value ?? []);
        break;
      case 'parentEmail':
        _student!.parentEmail = value ?? '';
        emailController.text = value ?? '';
        break;
      case 'parentPhone':
        _student!.parentPhone = value ?? '';
        phoneController.text = value ?? '';
        break;
      case 'preferredTeacherTraits':
        _student!.preferredTeacherTraits = value ?? '';
        teacherTraitsController.text = value ?? '';
        break;
      case 'subjects':
        _student!.subjects = List<String>.from(value ?? []);
        break;
      case 'proficiencyLevel':
        _student!.proficiencyLevel = value ?? '';
        break;
      case 'availableDays':
        _student!.availableDays = List<Map<String, dynamic>>.from(value ?? []);
        break;
      case 'learningMode':
        _student!.learningMode = value ?? '';
        break;
      case 'courseType':
        _student!.courseType = value ?? '';
        break;
      case 'lessonFrequency':
        _student!.lessonFrequency = value ?? 1;
        break;
      case 'courseDuration':
        _student!.courseDuration =
            value is Map<String, dynamic>
                ? value
                : {'hours': 2.0, 'unit': '小時/堂'};
        break;
      case 'priceRange':
        _student!.priceRange =
            value is Map<String, dynamic>
                ? value
                : {'min': 300.0, 'max': 700.0};
        break;
      case 'ratings':
        _student!.ratings = value ?? 0.0;
        break;
      case 'account':
        _student!.account = value ?? '';
        break;
      case 'password':
        _student!.password = value ?? '';
        break;
      case 'verificationCode':
        _student!.verificationCode = value ?? '';
        verificationCodeController.text = value ?? '';
        break;
      case 'verificationMethod':
        _student!.verificationMethod = value ?? '';
        break;
    }
    notifyListeners();
  }


  Future<void> register(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      setBusy(true);

      try {
        // 使用Email註冊Firebase
        final user = await _authService.signUpWithEmail(
          emailController.text,
          passwordController.text,
        );

        if (user != null) {
          // 發送驗證郵件
          await _authService.sendEmailVerification();

          // 更新學生資料中的帳號
          updateStudentInfo('account', emailController.text);
          updateStudentInfo('password', passwordController.text);

          // 發送資料到後端API
          if (_student != null) {
            try {
              await _apiService.post('/register', body: _student!.toJson());
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('註冊成功！')));
            } catch (e) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('註冊失敗: $e')));
            }
          }
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('註冊失敗: $e')));
      } finally {
        setBusy(false);
      }
    }
  }
}


