class Course {
  final String modifiedTime;
  final String courseTitle;
  final String courseStartTime;
  final String price;
  final List<String> courseCategories;
  final String introduction;
  final String venue;
  final List<String> venueMedia;
  final String grade;
  final String genderPerfer;
  final int teacherRate;
  final String teacherImage;
  final String note;

  Course({
    required this.modifiedTime,
    required this.courseTitle,
    required this.courseStartTime,
    required this.price,
    required this.courseCategories,
    required this.introduction,
    required this.venue,
    required this.venueMedia,
    required this.grade,
    required this.genderPerfer,
    required this.teacherRate,
    required this.teacherImage,
    required this.note,
  });

  factory Course.fromJson(Map<String, dynamic> json, {String? id}) {
    return Course(
      modifiedTime: json['modifiedTime'] ?? '',
      courseTitle: json['courseTitle'] ?? '',
      courseStartTime: json['courseStartTime'] ?? '',
      price: json['price'] ?? '',
      courseCategories: List<String>.from(json['courseCategories'] ?? []),
      introduction: json['introduction'] ?? '',
      venue: json['venue'] ?? '',
      venueMedia: List<String>.from(json['venueMedia'] ?? []),
      grade: json['grade'] ?? '',
      genderPerfer: json['genderPerfer'] ?? '',
      teacherRate: (json['teacherRate'] as List?)?.where((star) => star == true).length ?? 0,
      teacherImage: json['teacherImage'] ?? '',
      note: json['note'] ?? '',
    );
  }
}