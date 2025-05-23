import 'package:flutter/material.dart';
import 'package:zhi_duo_duo/viewmodels/base_view_model.dart';
import 'package:zhi_duo_duo/core/models/course.dart';
import 'package:zhi_duo_duo/core/services/api_service.dart';

class CourseBrowseViewModel extends BaseViewModel {
  final ApiService _apiService = ApiService();

  List<Course> _allCourses = [];
  List<Course> _filteredCourses = [];
  List<Course> get filteredCourses => _filteredCourses;

  bool _isBusy = false;
  bool get isBusy => _isBusy;

  String _selectedCategory = '全部';
  int _currentPage = 1;
  final int pageSize = 5;

  String get selectedCategory => _selectedCategory;
  int get currentPage => _currentPage;
  int get totalPages => (_filteredCourses.length / pageSize).ceil();

  List<Course> get currentPageCourses =>
      _filteredCourses.skip((_currentPage - 1) * pageSize).take(pageSize).toList();

  void setBusy(bool value) {
    _isBusy = value;
    notifyListeners();
  }

  Future<void> getCourses() async {
    setBusy(true);
    try {
      final data = await _apiService.get('/class_browse');
      _allCourses = (data as List).map((e) => Course.fromJson(e)).toList();
      applyFilter(_selectedCategory);
    } catch (e) {
      print("取得課程失敗: $e");
    } finally {
      setBusy(false);
    }
  }

  void applyFilter(String category) {
    _selectedCategory = category;
    _currentPage = 1;
    if (category == '全部') {
      _filteredCourses = _allCourses;
    } else {
      _filteredCourses = _allCourses
          .where((c) => c.courseCategories.contains(category))
          .toList();
    }
    notifyListeners();
  }

  void changePage(int page) {
    _currentPage = page;
    notifyListeners();
  }

  /// ✅ 進階搜尋邏輯整合
  void applyAdvancedFilter(Map<String, dynamic> filters) {
    String keyword = filters['keyword'] ?? '';
    DateTime? startDate = filters['startDate'];
    DateTime? endDate = filters['endDate'];
    double minRating = filters['minRating'] ?? 0;
    RangeValues priceRange = filters['priceRange'] ?? const RangeValues(500, 5000);
    List<String> categories = filters['categories'] ?? [];

    _currentPage = 1;
    _filteredCourses = _allCourses.where((course) {
      // 關鍵字
      if (keyword.isNotEmpty &&
          !course.courseTitle.toLowerCase().contains(keyword.toLowerCase()) &&
          !course.introduction.toLowerCase().contains(keyword.toLowerCase())) {
        return false;
      }

      print(course.courseStartTime);

      // 時間區間
      if (startDate != null && DateTime.parse(course.courseStartTime).isBefore(startDate)) return false;
      if (endDate != null && DateTime.parse(course.courseStartTime).isAfter(endDate)) return false;

      // 評分
      if (course.teacherRate < minRating) return false;

      // 價格區間
      var coursePrice = course.price.split('\$')[1].replaceAll(',', '');
      if (double.tryParse(coursePrice) == null || 
          double.parse(coursePrice) < priceRange.start || 
          double.parse(coursePrice) > priceRange.end) {
        return false;
      }

      // 類別條件
      if (categories.isNotEmpty &&
          !course.courseCategories.any((cat) => categories.contains(cat))) {
        return false;
      }

      print(course);
      return true;
    }).toList();

    notifyListeners();
  }
}
