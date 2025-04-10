import 'package:zhi_duo_duo/viewmodels/base_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zhi_duo_duo/core/models/student.dart';

class StudentReviewModel extends BaseViewModel {
  final _firestore = FirebaseFirestore.instance;

 Stream<List<Student>> getPendingStudents() {
  return FirebaseFirestore.instance
      .collection('students')
      .where('isApproved', isEqualTo: null)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => Student.fromJson(doc.data(), id: doc.id))
          .toList());
}


  Future<void> approveStudent(String id, bool approved) async {
    await _firestore.collection('students').doc(id).update({
      'isApproved': approved,
    });
  }
}