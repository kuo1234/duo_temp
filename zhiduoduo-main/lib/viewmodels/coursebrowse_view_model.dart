import 'package:zhi_duo_duo/viewmodels/base_view_model.dart';
import 'package:zhi_duo_duo/core/models/course.dart';
import 'package:zhi_duo_duo/core/services/api_service.dart';

class CourseBrowseViewModel extends BaseViewModel {
  final ApiService _apiService = ApiService();

  List<Course> courses = [];

  bool get isBusy => _isBusy;
  bool _isBusy = false;

  void setBusy(bool value) {
    _isBusy = value;
    notifyListeners(); // Ensure this class extends ChangeNotifier or similar
  }

  // 取得課程列表
  Future<void> getCourses() async {
    setBusy(true);
    try {
      final data = await _apiService.get('/class_browse');
      courses = (data as List).map((json) => Course.fromJson(json)).toList();
    } catch (e) {
      print("取得課程失敗: $e");
    } finally {
      setBusy(false);
    }
  }
}