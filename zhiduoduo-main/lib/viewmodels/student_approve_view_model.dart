import 'package:zhi_duo_duo/viewmodels/base_view_model.dart';
import 'package:zhi_duo_duo/core/models/student.dart';
import 'package:zhi_duo_duo/core/services/api_service.dart';

class StudentApproveModel extends BaseViewModel {
  final ApiService _apiService = ApiService();

  List<Student> students = [];
  bool get isBusy => _isBusy;
  bool _isBusy = false;

  void setBusy(bool value) {
    _isBusy = value;
    notifyListeners(); // Ensure this class extends ChangeNotifier or similar
  }
  // 取得待審核學生
  Future<void> getApproveStudents() async {
    setBusy(true);
    try {
      final data = await _apiService.get('/approve');
      students = (data as List).map((json) => Student.fromJson(json)).toList();
    } catch (e) {
      print("取得學生失敗: $e");
    } finally {
      setBusy(false);
    }
  }

  // 審核學生
  Future<void> approveStudent(String studentId, bool approved) async {
    setBusy(true);
    try {
      await _apiService.put(
        '/students/$studentId/approve',
        body: {'isApproved': approved},
      );
    } catch (e) {
      print("審核失敗: $e");
    } finally {
      setBusy(false);
    }
  }

  // 從列表中移除某位學生
  void removeStudentAt(int index) {
    students.removeAt(index);
    notifyListeners(); // 通知畫面更新
  }
}
