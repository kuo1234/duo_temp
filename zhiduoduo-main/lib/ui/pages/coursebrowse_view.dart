import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:zhi_duo_duo/core/models/course.dart';
import 'package:zhi_duo_duo/viewmodels/coursebrowse_view_model.dart';
import 'base_view.dart';
import 'search_filter_sheet.dart';

@RoutePage()
class CourseBrowse extends StatelessWidget {
  const CourseBrowse({super.key});

  final List<String> categories = const [
    '全部', '語言學習', '音樂', '藝術', '程式設計', '科學', '運動',
  ];

  @override
  Widget build(BuildContext context) {
  return BaseView<CourseBrowseViewModel>(
    modelProvider: () => CourseBrowseViewModel(),
    onModelReady: (model) => model.getCourses(),
    builder: (context, model, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildSearchBar(context, model),
              _buildCategoryChips(context, model),
              const SizedBox(height: 16),
              Expanded(
                child: model.isBusy
                    ? const Center(child: CircularProgressIndicator())
                    : model.filteredCourses.isEmpty
                        ? const Center(child: Text('目前沒有課程'))
                        : Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  itemCount: model.currentPageCourses.length,
                                  itemBuilder: (context, index) {
                                    final course = model.currentPageCourses[index];
                                    return _buildCourseCard(course);
                                  },
                                ),
                              ),
                              if (model.totalPages > 1)
                                _buildPagination(model),
                            ],
                          ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

  Widget _buildHeader() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text(
          '瀏覽課程',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, CourseBrowseViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: '搜尋課程...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                builder: (context) => FractionallySizedBox(
                  heightFactor: 0.9,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: SearchFilterSheet(
                      onApply: (filters) {
                        model.applyAdvancedFilter(filters);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips(BuildContext context, CourseBrowseViewModel model) {
  return SizedBox(
    height: 40,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: categories.length,
      separatorBuilder: (_, __) => const SizedBox(width: 8),
      itemBuilder: (context, index) {
        final category = categories[index];
        final isSelected = model.selectedCategory == category;
        return ChoiceChip(
          label: Text(category),
          selected: isSelected,
          onSelected: (_) => model.applyFilter(category),
          selectedColor: Colors.blue,
          backgroundColor: Colors.white,
          labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.blue),
          side: const BorderSide(color: Colors.blue),
        );
      },
    ),
  );
}
  Widget _buildCourseCard(Course course) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(course.courseTitle, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text('最後更新: ${course.modifiedTime}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
            Text('開課時間: ${course.courseStartTime}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
            Text('NT\$ ${course.price}', style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8,
              children: course.courseCategories.map((cat) => OutlinedButton(
                onPressed: () {},
                child: Text(cat),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.blue),
                  foregroundColor: Colors.blue,
                ),
              )).toList(),
            ),
            Text(course.introduction, style: const TextStyle(fontSize: 13)),
            Text('場地: ${course.venue}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
            Row(
              children: [
                Text('程度: ${course.grade}', style: const TextStyle(fontSize: 12)),
                const SizedBox(width: 16),
                Text('性別偏好: ${course.genderPerfer}', style: const TextStyle(fontSize: 12)),
              ],
            ),
            Row(
              children: List.generate(
                course.teacherRate,
                (index) => const Icon(Icons.star, color: Colors.amber, size: 16),
              ),
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(course.teacherImage),
              radius: 20,
            ),
            Text('備註: ${course.note}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildPagination(CourseBrowseViewModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_left),
            onPressed: model.currentPage > 1 ? () => model.changePage(model.currentPage - 1) : null,
          ),
          ..._buildPageButtons(model),
          IconButton(
            icon: const Icon(Icons.arrow_right),
            onPressed: model.currentPage < model.totalPages ? () => model.changePage(model.currentPage + 1) : null,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPageButtons(CourseBrowseViewModel model) {
    const maxButtons = 5;
    int startPage = (model.currentPage - (maxButtons ~/ 2)).clamp(1, model.totalPages);
    int endPage = (startPage + maxButtons - 1).clamp(1, model.totalPages);
    startPage = (endPage - maxButtons + 1).clamp(1, model.totalPages);

    return List.generate(endPage - startPage + 1, (index) {
      final page = startPage + index;
      final isSelected = model.currentPage == page;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: GestureDetector(
          onTap: () => model.changePage(page),
          child: CircleAvatar(
            radius: 16,
            backgroundColor: isSelected ? Colors.blue : Colors.grey[300],
            child: Text(
              '$page',
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    });
  }
}