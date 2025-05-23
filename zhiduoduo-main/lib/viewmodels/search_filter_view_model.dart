import 'package:flutter/material.dart';
import 'package:zhi_duo_duo/viewmodels/base_view_model.dart';

class SearchFilterViewModel extends BaseViewModel {
  final TextEditingController keywordController = TextEditingController();

  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  RangeValues priceRange = const RangeValues(0, 5000);
  double teacherRating = 3.0;

  final List<String> categories = ["語言", "音樂", "藝術", "運動", "學術", "烹飪", "電腦", "其他"];
  final List<bool> selectedCategories = List.filled(8, false);

  void setStartDate(DateTime? date) {
    selectedStartDate = date;
    notifyListeners();
  }

  void setEndDate(DateTime? date) {
    selectedEndDate = date;
    notifyListeners();
  }

  void setPriceRange(RangeValues range) {
    priceRange = range;
    notifyListeners();
  }

  void setTeacherRating(double rating) {
    teacherRating = rating;
    notifyListeners();
  }

  void toggleCategory(int index, bool selected) {
    selectedCategories[index] = selected;
    notifyListeners();
  }

  void resetFilters() {
    selectedStartDate = null;
    selectedEndDate = null;
    priceRange = const RangeValues(0, 5000);
    teacherRating = 3.0;
    for (int i = 0; i < selectedCategories.length; i++) {
      selectedCategories[i] = false;
    }
    keywordController.clear();
    notifyListeners();
  }

  Map<String, dynamic> getFilters() {
    final List<String> chosenCategories = [];
    for (int i = 0; i < categories.length; i++) {
      if (selectedCategories[i]) {
        chosenCategories.add(categories[i]);
      }
    }
    return {
      'keyword': keywordController.text.trim(),
      'startDate': selectedStartDate,
      'endDate': selectedEndDate,
      'minRating': teacherRating,
      'priceRange': priceRange,
      'categories': chosenCategories,
    };
  }
}