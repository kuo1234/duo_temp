import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:zhi_duo_duo/viewmodels/base_view_model.dart';
import 'package:zhi_duo_duo/core/models/course.dart';

class CourseSearchViewModel extends BaseViewModel {
  List<Course> courses = [];
  bool get isBusy => _isBusy;
  bool _isBusy = false;

  void setBusy(bool value) {
    _isBusy = value;
    notifyListeners();
  }

  Future<void> getCourses() async {
    setBusy(true);
    try {
      final response = await http.get(Uri.parse('http://192.168.254.90:5000/api/class_search'));
      print('Raw response body: ${response.body}'); // Log raw response
      print('Status code: ${response.statusCode}'); // Log status code

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Parsed data: $data'); // Log parsed JSON
        print('Type of data[\'courses\']: ${data['courses'].runtimeType}'); // Log type of courses field

        if (data['courses'] != null && data['courses'] is List) {
          courses = (data['courses'] as List).map((json) => Course.fromJson(json)).toList();
        } else {
          print('Error: "courses" is not a List, it is ${data['courses'].runtimeType}');
          courses = [];
        }
      } else {
        print('API error: ${response.statusCode}, ${response.body}');
        courses = [];
      }
    } catch (e) {
      print("Error fetching courses from API: $e");
      courses = [];
    } finally {
      setBusy(false);
    }
  }

  void removeCourseAt(int index) {
    courses.removeAt(index);
    notifyListeners();
  }
}