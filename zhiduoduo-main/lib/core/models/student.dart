class Student {
  String studentName;
  String parentName;
  DateTime birthDate;
  String gender;
  String profilePicture;
  List<String> interests;
  String parentEmail;
  String parentPhone;
  String preferredTeacherTraits;

  // Learning needs
  List<String> subjects;
  String proficiencyLevel;
  List<Map<String, dynamic>> availableDays;
  String learningMode;
  String courseType;
  Map<String, dynamic> courseDuration;
  int lessonFrequency;
  Map<String, dynamic> priceRange;
  double ratings;

  // Account information
  String account;
  String password;
  String verificationCode;
  String verificationMethod;
  String? id;
  bool isApproved;

  Student({
    this.id,
    required this.studentName,
    required this.parentName,
    required this.birthDate,
    required this.gender,
    required this.profilePicture,
    required this.interests,
    required this.parentEmail,
    required this.parentPhone,
    required this.preferredTeacherTraits,
    required this.subjects,
    required this.proficiencyLevel,
    required this.availableDays,
    required this.learningMode,
    required this.courseType,
    required this.courseDuration,
    required this.lessonFrequency,
    required this.priceRange,
    required this.ratings,
    required this.account,
    required this.password,
    required this.verificationCode,
    required this.verificationMethod,
    this.isApproved = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'studentName': studentName,
      'parentName': parentName,
      'birthDate': birthDate.toIso8601String(),
      'gender': gender,
      'profilePicture': profilePicture,
      'interests': interests,
      'parentEmail': parentEmail,
      'parentPhone': parentPhone,
      'preferredTeacherTraits': preferredTeacherTraits,
      'subjects': subjects,
      'proficiencyLevel': proficiencyLevel,
      'availableDays': availableDays,
      'learningMode': learningMode,
      'courseType': courseType,
      'courseDuration': courseDuration,
      'lessonFrequency': lessonFrequency,
      'priceRange': priceRange,
      'ratings': ratings,
      'account': account,
      'password': password,
      'verificationCode': verificationCode,
      'verificationMethod': verificationMethod,
      'isApproved': false, // 預設為false
    };
  }

  factory Student.fromJson(Map<String, dynamic> json, {String? id}) {
    return Student(
      id: json['id'] ?? '',
      studentName: json['studentName'] ?? '',
      parentName: json['parentName'] ?? '',
      birthDate:
          json['birthDate'] != null
              ? DateTime.parse(json['birthDate'])
              : DateTime.now(),
      gender: json['gender'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
      interests:
          json['interests'] != null ? List<String>.from(json['interests']) : [],
      parentEmail: json['parentEmail'] ?? '',
      parentPhone: json['parentPhone'] ?? '',
      preferredTeacherTraits: json['preferredTeacherTraits'] ?? '',
      subjects:
          json['subjects'] != null ? List<String>.from(json['subjects']) : [],
      proficiencyLevel: json['proficiencyLevel'] ?? '',
      availableDays:
          json['availableDays'] != null
              ? List<Map<String, dynamic>>.from(json['availableDays'])
              : [],
      learningMode: json['learningMode'] ?? '',
      courseType: json['courseType'] ?? '',
      courseDuration:
          json['courseDuration'] != null
              ? Map<String, dynamic>.from(json['courseDuration'])
              : {'hours': 0.0, 'unit': '小時/堂'}, // 預設值
      lessonFrequency: json['lessonFrequency'] ?? 0, // 新增
      priceRange:
          json['priceRange'] != null
              ? Map<String, dynamic>.from(json['priceRange'])
              : {'min': 0.0, 'max': 0.0},
      ratings: json['ratings']?.toDouble() ?? 0.0,
      account: json['account'] ?? '',
      password: json['password'] ?? '',
      verificationCode: json['verificationCode'] ?? '',
      verificationMethod: json['verificationMethod'] ?? '',
      isApproved: json['isApproved'] ?? false,
    );
  }
  
  
  }
