import 'package:flutter/material.dart';

class SearchFilterSheet extends StatefulWidget {
  final void Function(Map<String, dynamic>) onApply;

  const SearchFilterSheet({super.key, required this.onApply});

  @override
  State<SearchFilterSheet> createState() => _SearchFilterSheetState();
}

class _SearchFilterSheetState extends State<SearchFilterSheet> {
  final TextEditingController keywordController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;
  double minRating = 0;
  RangeValues priceRange = const RangeValues(500, 5000);
  List<String> selectedCategories = [];

  final List<String> categories = [
    '語言學習', '音樂', '藝術', '運動', '科學', '程式設計', '烹飪', '商業', '健康與保健',
  ];

  Future<void> _pickDate(BuildContext context, bool isStart) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2030),
    );
    if (date != null) {
      setState(() {
        if (isStart) startDate = date;
        else endDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              Center(
                child: Text(
                  '搜尋課程',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: keywordController,
                decoration: InputDecoration(
                  labelText: '關鍵字',
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _pickDate(context, true),
                      child: Text(
                        startDate == null
                            ? '最早開課時間'
                            : '${startDate!.toLocal()}'.split(' ')[0],
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _pickDate(context, false),
                      child: Text(
                        endDate == null
                            ? '最晚開課時間'
                            : '${endDate!.toLocal()}'.split(' ')[0],
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text('教師最低評分'),
              Slider(
                value: minRating,
                onChanged: (value) => setState(() => minRating = value),
                min: 0,
                max: 5,
                divisions: 5,
                activeColor: Colors.blue,
                inactiveColor: Colors.grey[300],
                label: minRating.toStringAsFixed(1),
              ),
              const SizedBox(height: 16),
              Text('價格範圍'),
              RangeSlider(
                values: priceRange,
                onChanged: (values) => setState(() => priceRange = values),
                min: 500,
                max: 5000,
                divisions: 9,
                activeColor: Colors.blue,
                inactiveColor: Colors.grey[300],
                labels: RangeLabels(
                  'NT\$ ${priceRange.start.round()}',
                  'NT\$ ${priceRange.end.round()}',
                ),
              ),
              const SizedBox(height: 16),
              Text('課程分類'),
              Wrap(
                spacing: 8,
                children: categories.map((cat) {
                  final selected = selectedCategories.contains(cat);
                  return ChoiceChip(
                    label: Text(cat),
                    selected: selected,
                    onSelected: (val) {
                      setState(() {
                        selected
                            ? selectedCategories.remove(cat)
                            : selectedCategories.add(cat);
                      });
                    },
                    selectedColor: Colors.blue,
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(
                      color: selected ? Colors.white : Colors.blue,
                    ),
                    side: BorderSide(color: Colors.blue),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  final filters = {
                    'keyword': keywordController.text.trim(),
                    'startDate': startDate,
                    'endDate': endDate,
                    'minRating': minRating,
                    'priceRange': priceRange,
                    'categories': selectedCategories,
                  };
                  widget.onApply(filters);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    '搜尋課程',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}