// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:zhi_duo_duo/viewmodels/base_view_model.dart';
import 'package:zhi_duo_duo/core/models/student.dart';
import 'package:zhi_duo_duo/core/services/api_service.dart';

class StudentApproveModel extends BaseViewModel {
  final ApiService _apiService = ApiService();
  Future<List<Student>> getApproveStudents() async {
    final data = await _apiService.get('/approve');
    return (data as List).map((json) => Student.fromJson(json)).toList();
  }

  Future<void> approveStudent(String studentId, bool approved) async {
    await _apiService.put(
      '/students/$studentId/approve',
      body: {'isApproved': true},
    );
  }
}
