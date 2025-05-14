
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:zhi_duo_duo/core/models/course.dart';
import 'package:zhi_duo_duo/viewmodels/coursebrowse_view_model.dart';
import 'base_view.dart';

@RoutePage()
/// 瀏覽課程頁面
class CourseBrowse extends StatelessWidget {
  const CourseBrowse({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<CourseBrowseViewModel>(
      modelProvider: () => CourseBrowseViewModel(),
      onModelReady: (model) => model.getCourses(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      '瀏覽課程',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: '搜尋課程...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildCategoryChip('全部', true),
                      _buildCategoryChip('語言學習', false),
                      _buildCategoryChip('音樂', false),
                      _buildCategoryChip('藝術', false),
                      _buildCategoryChip('程式設計', false),
                      _buildCategoryChip('科學', false),
                      _buildCategoryChip('運動', false),
                    ],
                  ),
                  SizedBox(height: 24),
                  if (model.isBusy)
                    Center(child: CircularProgressIndicator())
                  else if (model.courses.isEmpty)
                    Center(child: Text('目前沒有課程'))
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: model.courses.length,
                      itemBuilder: (context, index) {
                        final course = model.courses[index];
                        return _buildCourseCard(course);
                      },
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategoryChip(String label, bool selected) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) {},
      selectedColor: Colors.blue,
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: selected ? Colors.white : Colors.blue,
      ),
      side: BorderSide(color: Colors.blue),
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


  Widget _buildLevelTag(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}