// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:zhi_duo_duo/viewmodels/base_view_model.dart';
import 'package:zhi_duo_duo/core/models/student.dart';
import 'package:zhi_duo_duo/core/services/api_service.dart';

class StudentReviewModel extends BaseViewModel {
  final ApiService _apiService = ApiService();
  Future<List<Student>> getPendingStudents() async {
    final data = await _apiService.get('/review');
    return (data as List).map((json) => Student.fromJson(json)).toList();
  }

  Future<void> approveStudent(String id, bool approved) async {
    await _apiService.put(
      '/students/$id/approve',
      body: {'isApproved': approved},
    );
  }
}
