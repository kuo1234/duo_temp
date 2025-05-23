import 'package:flutter/material.dart';
import 'base_view.dart';
import 'package:zhi_duo_duo/viewmodels/search_filter_view_model.dart';

class SearchFilterSheet extends StatelessWidget {
  final void Function(Map<String, dynamic>) onApply;

  const SearchFilterSheet({super.key, required this.onApply});

  @override
  Widget build(BuildContext context) {
    return BaseView<SearchFilterViewModel>(
      modelProvider: () => SearchFilterViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("課程搜尋篩選",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 搜尋框
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: model.keywordController,
                      decoration: InputDecoration(
                        hintText: "搜尋課程關鍵字",
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // 開課時間
                  _buildSectionTitle("開課時間"),
                  _buildDateRangePicker(context, model),
                  
                  const SizedBox(height: 20),
                  
                  // 價格區間
                  _buildSectionTitle("價格區間"),
                  _buildPriceRangeSlider(model),
                  
                  const SizedBox(height: 20),
                  
                  // 教師評分
                  _buildSectionTitle("教師評分"),
                  _buildTeacherRatingSelector(model),
                  
                  const SizedBox(height: 20),
                  
                  // 課程分類
                  _buildSectionTitle("課程分類"),
                  _buildCategorySelector(model),
                  
                  const SizedBox(height: 30),
                  
                  // 搜尋按鈕
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _handleSearch(model);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "搜尋課程",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 15),
                  
                  // 重置按鈕
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        _resetFilters(model);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "重置篩選條件",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // 小標題樣式
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // 開課時間選擇器
  Widget _buildDateRangePicker(BuildContext context, SearchFilterViewModel model) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: model.selectedStartDate ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (pickedDate != null) {
                      model.setStartDate(pickedDate);
                      if (model.selectedEndDate != null && model.selectedEndDate!.isBefore(pickedDate)) {
                        model.setEndDate(null);
                      }
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          model.selectedStartDate != null ? model.selectedStartDate!.toString().split(' ').first : "開始日期",
                          style: TextStyle(
                            color: model.selectedStartDate != null ? Colors.black : Colors.grey,
                          ),
                        ),
                        const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              const Text("至"),
              const SizedBox(width: 15),
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: model.selectedEndDate ?? (model.selectedStartDate != null ? model.selectedStartDate!.add(const Duration(days: 1)) : DateTime.now().add(const Duration(days: 1))),
                      firstDate: model.selectedStartDate != null ? model.selectedStartDate! : DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (pickedDate != null) {
                      model.setEndDate(pickedDate);
                      if (model.selectedStartDate != null && model.selectedStartDate!.isAfter(pickedDate)) {
                        model.setStartDate(null);
                      }
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          model.selectedEndDate != null ? model.selectedEndDate!.toString().split(' ').first : "結束日期",
                          style: TextStyle(
                            color: model.selectedEndDate != null ? Colors.black : Colors.grey,
                          ),
                        ),
                        const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 價格區間選擇器
  Widget _buildPriceRangeSlider(SearchFilterViewModel model) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          RangeSlider(
            values: model.priceRange,
            min: 0,
            max: 10000,
            divisions: 100,
            labels: RangeLabels(
              "NT\$${model.priceRange.start.toInt()}",
              "NT\$${model.priceRange.end.toInt()}",
            ),
            onChanged: (RangeValues values) {
              model.setPriceRange(values);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "NT\$${model.priceRange.start.toInt()}",
                style: TextStyle(color: Colors.grey[700]),
              ),
              Text(
                "NT\$${model.priceRange.end.toInt()}",
                style: TextStyle(color: Colors.grey[700]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 教師評分選擇器
  Widget _buildTeacherRatingSelector(SearchFilterViewModel model) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${model.teacherRating.toStringAsFixed(1)} 星以上",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < model.teacherRating.floor() ? Icons.star : (index < model.teacherRating ? Icons.star_half : Icons.star_border),
                    color: Colors.amber,
                    size: 20,
                  );
                }),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Slider(
            value: model.teacherRating,
            min: 0,
            max: 5,
            divisions: 10,
            label: model.teacherRating.toStringAsFixed(1),
            onChanged: (value) {
              model.setTeacherRating(value);
            },
          ),
        ],
      ),
    );
  }

  // 課程分類選擇器
  Widget _buildCategorySelector(SearchFilterViewModel model) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        child: Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(
            model.categories.length,
            (index) => FilterChip(
              label: Text(model.categories[index]),
              selected: model.selectedCategories[index],
              onSelected: (selected) {
                model.toggleCategory(index, selected);
              },
              backgroundColor: Colors.grey[100],
              selectedColor: Colors.blue[100],
              checkmarkColor: Colors.blue[800],
              labelStyle: TextStyle(
                color: model.selectedCategories[index] ? Colors.blue[800] : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 處理搜尋操作
  void _handleSearch(SearchFilterViewModel model) {
    // 獲取所有選中的課程分類
    final List<String> chosenCategories = [];
    for (int i = 0; i < model.categories.length; i++) {
      if (model.selectedCategories[i]) {
        chosenCategories.add(model.categories[i]);
      }
    }

    final filters = {
      'keyword': model.keywordController.text.trim(),
      'startDate': model.selectedStartDate,
      'endDate': model.selectedEndDate,
      'minRating': model.teacherRating,
      'priceRange': model.priceRange,
      'categories': chosenCategories,
    };

    onApply(filters);
  }

  // 重置所有篩選條件
  void _resetFilters(SearchFilterViewModel model) {
    model.keywordController.clear();
    model.setStartDate(null);
    model.setEndDate(null);
    model.setPriceRange(const RangeValues(0, 5000));
    model.setTeacherRating(3.0);
    for (int i = 0; i < model.selectedCategories.length; i++) {
      model.toggleCategory(i, false);
    }
  }
}