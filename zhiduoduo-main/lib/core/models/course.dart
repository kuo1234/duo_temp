class Course {
  String modifiedTime;
  String courseTitle;
  String courseStartTime;
  String price;
  List<String> courseCategories;
  String introduction;
  String venue;
  List<String> venueMedia;
  String grade;
  String genderPerfer;
  int teacherRate;
  String teacherImage;
  String note;
  String? id;

  Course({
    this.id,
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

  Map<String, dynamic> tojson(){
    return {
      'id': id,
      'modifiedTime': modifiedTime,
      'courseTitle': courseTitle,
      'courseStartTime': courseStartTime,
      'price': price,
      'courseCategories': courseCategories,
      'introduction': introduction,
      'venue': venue,
      'venueMedia': venueMedia,
      'grade': grade,
      'genderPerfer': genderPerfer,
      'teacherRate': teacherRate,
      'teacherImage': teacherImage,
      'note': note,
    };
  }




  factory Course.fromJson(Map<String, dynamic> json, {String? id}) {
    return Course(
      id: json['id'] ?? '',
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