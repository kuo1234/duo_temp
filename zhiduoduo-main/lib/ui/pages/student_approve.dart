import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:zhi_duo_duo/viewmodels/student_approve_view_model.dart';
import 'package:zhi_duo_duo/ui/pages/base_view.dart';
import 'package:zhi_duo_duo/core/models/student.dart';
import 'dart:convert';
@RoutePage()
class StudentApprove extends StatelessWidget {
  const StudentApprove({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<StudentApproveModel>(
      modelProvider: () => StudentApproveModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                context.router.pop(); // 使用 auto_route 回上一頁
              },
            ),
            title: Text('學生審核'),
          ),
          body: FutureBuilder<List<Student>>(
            future: model.getApproveStudents(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              final students = snapshot.data ?? [];

              if (students.isEmpty) {
                return Center(child: Text('沒有待審核的學生'));
              }

              return ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];

                  return Card(
                    margin: EdgeInsets.all(10),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "學生姓名：${student.studentName}",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Text("家長姓名：${student.parentName}"),
                                    Text("性別：${student.gender}"),
                                    Text("生日：${student.birthDate.toLocal()}".split(' ')[0]),
                                    Text("Email：${student.parentEmail}"),
                                    Text("電話：${student.parentPhone}"),
                                    Text("驗證方式：${student.verificationMethod}"),
                                  ],
                                ),
                              ),
                              if (student.profilePicture.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Image.memory(
                                    base64Decode(student.profilePicture),
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () => model.approveStudent(student.id ?? '', true),
                                child: Text('通過'),
                              ),
                              SizedBox(width: 8),
                              OutlinedButton(
                                onPressed: () => model.approveStudent(student.id ?? '', false),
                                child: Text('不通過'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
