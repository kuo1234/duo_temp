// import 'dart:io';
import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:intl/intl.dart';
import 'package:zhi_duo_duo/ui/pages/base_view.dart';
import 'package:zhi_duo_duo/viewmodels/student_view_model.dart';

@RoutePage()
class StudentRegistrationPage extends StatelessWidget {
  const StudentRegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<StudentViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(title: Text('學生註冊')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: model.formKey,
              child: ListView(
                children: [
                  // 基本資料區塊
                  _buildSectionHeader('基本資料'),

                  // 大頭貼選擇
                  _buildProfilePicturePicker(model),
                  SizedBox(height: 16),

                  // 學生姓名
                  TextFormField(
                    controller: model.studentNameController,
                    decoration: InputDecoration(labelText: '學生姓名'),
                    validator:
                        (value) =>
                            value == null || value.isEmpty ? '請輸入學生姓名' : null,
                    onChanged: (value) {
                      model.updateStudentInfo('studentName', value);
                    },
                    onSaved: (value) {
                      model.updateStudentInfo('studentName', value);
                    },
                  ),
                  SizedBox(height: 8),

                  // 家長姓名
                  TextFormField(
                    controller: model.parentNameController,
                    decoration: InputDecoration(labelText: '家長姓名'),
                    validator:
                        (value) =>
                            value == null || value.isEmpty ? '請輸入家長姓名' : null,
                    onChanged: (value) {
                      model.updateStudentInfo('parentName', value);
                    },
                    onSaved: (value) {
                      model.updateStudentInfo('parentName', value);
                    },
                  ),
                  SizedBox(height: 8),

                  // 出生日期
                  _buildDatePicker(context, model),
                  SizedBox(height: 8),

                  // 性別
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: '性別'),
                    value: model.selectedGender,
                    items:
                        ['男', '女', '其他']
                            .map(
                              (gender) => DropdownMenuItem(
                                value: gender,
                                child: Text(gender),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        model.selectedGender = value;
                        model.updateStudentInfo('gender', value);
                      }
                    },
                    validator: (value) => value == null ? '請選擇性別' : null,
                  ),
                  SizedBox(height: 16),

                  // 興趣愛好區塊
                  _buildSectionHeader('興趣愛好'),
                  _buildInterestCheckboxes(model),
                  SizedBox(height: 16),

                  // 聯絡資訊區塊
                  _buildSectionHeader('聯絡資訊'),

                  // 家長Email
                  TextFormField(
                    controller: model.emailController,
                    decoration: InputDecoration(labelText: '家長Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '請輸入Email';
                      }
                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value)) {
                        return '請輸入有效的Email格式';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      model.updateStudentInfo('parentEmail', value);
                    },
                    onSaved: (value) {
                      model.updateStudentInfo('parentEmail', value);
                    },
                  ),
                  SizedBox(height: 8),

                  // 家長電話
                  TextFormField(
                    controller: model.phoneController,
                    decoration: InputDecoration(labelText: '家長手機'),
                    keyboardType: TextInputType.phone,
                    validator:
                        (value) =>
                            value == null || value.isEmpty ? '請輸入家長手機' : null,
                    onChanged: (value) {
                      model.updateStudentInfo('parentPhone', value);
                    },
                    onSaved: (value) {
                      model.updateStudentInfo('parentPhone', value);
                    },
                  ),
                  SizedBox(height: 16),

                  // 學習需求
                  _buildSectionHeader('學習需求'),

                  // 喜歡老師的特質
                  TextFormField(
                    controller: model.teacherTraitsController,
                    decoration: InputDecoration(
                      labelText: '喜歡老師的特質',
                      hintText: '例如：有耐心，會說故事',
                    ),
                    maxLines: 2,
                    onChanged: (value) {
                      model.updateStudentInfo('preferredTeacherTraits', value);
                    },
                    onSaved: (value) {
                      model.updateStudentInfo('preferredTeacherTraits', value);
                    },
                  ),
                  SizedBox(height: 16),

                  // 想學的科目或技能
                  _buildSubjectsMultiSelect(model),
                  SizedBox(height: 16),

                  // 程度
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: '學習程度'),
                    value: model.selectedProficiencyLevel,
                    items:
                        ['初學者', '中級', '高級']
                            .map(
                              (level) => DropdownMenuItem(
                                value: level,
                                child: Text(level),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        model.selectedProficiencyLevel = value;
                        model.updateStudentInfo('proficiencyLevel', value);
                      }
                    },
                  ),
                  SizedBox(height: 16),

                  // 可用時間
                  _buildSectionHeader('可用時間'),
                  _buildAvailabilitySelector(context, model),
                  SizedBox(height: 16),

                  // 學習模式
                  _buildLearningModeRadio(model),
                  SizedBox(height: 16),

                  // 課程類型
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: '課程類型'),
                    value: model.selectedCourseType,
                    items:
                        ['一對一', '補習班', '團體課程']
                            .map(
                              (type) => DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        model.selectedCourseType = value;
                        model.updateStudentInfo('courseType', value);
                      }
                    },
                  ),
                  SizedBox(height: 16),

                  // 課程長度設定
                  _buildCourseDurationSelector(model),
                  SizedBox(height: 16),

                  // 每週上課次數設定
                  _buildLessonFrequencySelector(model),
                  SizedBox(height: 16),

                  // 價格範圍設定
                  _buildPriceRangeSlider(model),
                  SizedBox(height: 16),

                  // 老師評分要求
                  _buildTeacherRatingSlider(model),
                  SizedBox(height: 16),

                  // 帳號資訊區塊
                  _buildSectionHeader('帳號資訊'),

                  // 密碼
                  TextFormField(
                    controller: model.passwordController,
                    decoration: InputDecoration(labelText: '密碼'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '請輸入密碼';
                      }
                      if (value.length < 6) {
                        return '密碼長度至少需要6位';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      model.updateStudentInfo('password', value);
                    },
                    onSaved: (value) {
                      model.updateStudentInfo('password', value);
                    },
                  ),
                  SizedBox(height: 8),

                  // 驗證方式選擇
                  _buildVerificationMethodRadio(model),
                  SizedBox(height: 8),

                  // 驗證碼
                  TextFormField(
                    controller: model.verificationCodeController,
                    decoration: InputDecoration(labelText: '驗證碼'),
                    onChanged: (value) {
                      model.updateStudentInfo('verificationCode', value);
                    },
                    onSaved: (value) {
                      model.updateStudentInfo('verificationCode', value);
                    },
                  ),

                  SizedBox(height: 24),

                  // 註冊按鈕
                  ElevatedButton(
                    onPressed:
                        model.busy ? null : () => model.register(context),
                    // model.busy ? null : () => model.register(context),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    child:
                        model.busy
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text('註冊', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      modelProvider: () => StudentViewModel(),
    );
  }

  // 區段標題
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          Divider(thickness: 1),
        ],
      ),
    );
  }

  // 大頭貼選擇器 - Updated to use base64 images
  Widget _buildProfilePicturePicker(StudentViewModel model) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey),
            ),
            child: ClipOval(child: _getProfileImage(model)),
          ),
          TextButton(onPressed: model.pickImage, child: Text('選擇大頭貼')),
        ],
      ),
    );
  }

  Widget _getProfileImage(StudentViewModel model) {
    if (model.profileImageBytes != null) {
      return Image.memory(model.profileImageBytes!, fit: BoxFit.cover);
    } else if (model.profileImageBase64 != null &&
        model.profileImageBase64!.isNotEmpty) {
      try {
        final bytes = base64Decode(model.profileImageBase64!);
        return Image.memory(bytes, fit: BoxFit.cover);
      } catch (e) {
        print('Error decoding base64 image: $e');
      }
    } else if (model.profileImageFile != null && !kIsWeb) {
      return Image.file(model.profileImageFile!, fit: BoxFit.cover);
    }

    return Icon(Icons.person, size: 80, color: Colors.grey);
  }

  // 日期選擇
  Widget _buildDatePicker(BuildContext context, StudentViewModel model) {
    return InkWell(
      onTap: () => model.selectDate(context),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: '出生日期',
          border: OutlineInputBorder(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(DateFormat('yyyy-MM-dd').format(model.selectedDate)),
            Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }

  // 興趣選框
  Widget _buildInterestCheckboxes(StudentViewModel model) {
    return Wrap(
      spacing: 8.0,
      children:
          model.interestOptions.map((interest) {
            final isSelected = model.selectedInterests.contains(interest);
            return FilterChip(
              label: Text(interest),
              selected: isSelected,
              onSelected: (selected) {
                model.toggleInterest(interest);
              },
              backgroundColor: Colors.grey[200],
              selectedColor: Colors.lightBlue[100],
            );
          }).toList(),
    );
  }

  // 科目多選框
  Widget _buildSubjectsMultiSelect(StudentViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('想學的科目或技能:'),
        SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          children:
              model.subjectOptions.map((subject) {
                final isSelected = model.selectedSubjects.contains(subject);
                return FilterChip(
                  label: Text(subject),
                  selected: isSelected,
                  onSelected: (selected) {
                    model.toggleSubject(subject);
                  },
                  backgroundColor: Colors.grey[200],
                  selectedColor: Colors.lightBlue[100],
                );
              }).toList(),
        ),
      ],
    );
  }

  // 可用時間選擇
  Widget _buildAvailabilitySelector(
    BuildContext context,
    StudentViewModel model,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('選擇可上課時段:'),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: () => _showTimeSlotDialog(context, model),
          child: Text('新增時段'),
        ),
        SizedBox(height: 8),
        ...model.availableDaysList.asMap().entries.map((entry) {
          final index = entry.key;
          final timeSlot = entry.value;
          return Card(
            margin: EdgeInsets.symmetric(vertical: 4),
            child: ListTile(
              title: Text(
                '${timeSlot['day']} (${timeSlot['startTime']} - ${timeSlot['endTime']})',
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => model.removeavailableDays(index),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  // 時段選擇
  void _showTimeSlotDialog(BuildContext context, StudentViewModel model) {
    String selectedDay = model.weekdays[0];
    String startTime = '08:00';
    String endTime = '10:00';

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('新增可用時段'),
            content: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(labelText: '星期'),
                      value: selectedDay,
                      items:
                          model.weekdays
                              .map(
                                (day) => DropdownMenuItem(
                                  value: day,
                                  child: Text(day),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => selectedDay = value);
                        }
                      },
                    ),
                    SizedBox(height: 8),
                    InkWell(
                      onTap: () async {
                        final TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(hour: 8, minute: 0),
                        );
                        if (picked != null) {
                          setState(() {
                            startTime =
                                '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
                          });
                        }
                      },
                      child: InputDecorator(
                        decoration: InputDecoration(labelText: '開始時間'),
                        child: Text(startTime),
                      ),
                    ),
                    SizedBox(height: 8),
                    InkWell(
                      onTap: () async {
                        final TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(hour: 10, minute: 0),
                        );
                        if (picked != null) {
                          setState(() {
                            endTime =
                                '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
                          });
                        }
                      },
                      child: InputDecorator(
                        decoration: InputDecoration(labelText: '結束時間'),
                        child: Text(endTime),
                      ),
                    ),
                  ],
                );
              },
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('取消'),
              ),
              TextButton(
                onPressed: () {
                  model.addavailableDays(selectedDay, startTime, endTime);
                  Navigator.pop(context);
                },
                child: Text('確定'),
              ),
            ],
          ),
    );
  }

  // 學習模式選擇
  Widget _buildLearningModeRadio(StudentViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('學習模式:'),
        RadioListTile<String>(
          title: Text('線上'),
          value: '線上',
          groupValue: model.selectedLearningMode,
          onChanged: (value) {
            if (value != null) {
              model.selectedLearningMode = value;
              model.updateStudentInfo('learningMode', value);
            }
          },
        ),
        RadioListTile<String>(
          title: Text('線下'),
          value: '線下',
          groupValue: model.selectedLearningMode,
          onChanged: (value) {
            if (value != null) {
              model.selectedLearningMode = value;
              model.updateStudentInfo('learningMode', value);
            }
          },
        ),
        RadioListTile<String>(
          title: Text('混合'),
          value: '混合',
          groupValue: model.selectedLearningMode,
          onChanged: (value) {
            if (value != null) {
              model.selectedLearningMode = value;
              model.updateStudentInfo('learningMode', value);
            }
          },
        ),
      ],
    );
  }

  // 課程長度
  Widget _buildCourseDurationSelector(StudentViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('課程長度:'),
        Row(
          children: [
            Expanded(
              child: Slider(
                value: model.courseDurationHours,
                min: 0.5,
                max: 8,
                divisions: 15,
                label: model.courseDurationHours.toString(),
                onChanged: (value) {
                  model.updateCourseDuration(value, model.courseDurationUnit);
                },
              ),
            ),
            Text('${model.courseDurationHours} 小時/堂'),
          ],
        ),
      ],
    );
  }

  // 每週上課次數
  Widget _buildLessonFrequencySelector(StudentViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('每週上課次數:'),
        Row(
          children: [
            Expanded(
              child: Slider(
                value: model.lessonFrequency.toDouble(),
                min: 1,
                max: 7,
                divisions: 6,
                label: '${model.lessonFrequency} 次/週',
                onChanged: (value) {
                  model.updateLessonFrequency(value.toInt());
                },
              ),
            ),
            Text('${model.lessonFrequency} 次/週'),
          ],
        ),
      ],
    );
  }

  // 價格範圍
  Widget _buildPriceRangeSlider(StudentViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('價格範圍:'),
        RangeSlider(
          values: model.priceRangeValues,
          min: 0,
          max: 2000,
          divisions: 40,
          labels: RangeLabels(
            '${model.priceRangeValues.start.round()} 元',
            '${model.priceRangeValues.end.round()} 元',
          ),
          onChanged: (values) {
            model.updatePriceRange(values);
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${model.priceRangeValues.start.round()} 元/小時'),
              Text('${model.priceRangeValues.end.round()} 元/小時'),
            ],
          ),
        ),
      ],
    );
  }

  // 老師評分
  Widget _buildTeacherRatingSlider(StudentViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('老師評分要求:'),
        Row(
          children: [
            Expanded(
              child: Slider(
                value: model.minimumRating,
                min: 0.0,
                max: 5.0,
                divisions: 10,
                label: '${model.minimumRating.toStringAsFixed(1)} 星',
                onChanged: (value) {
                  model.updateMinimumRating(value);
                },
              ),
            ),
            Text('${model.minimumRating.toStringAsFixed(1)} 星以上'),
          ],
        ),
      ],
    );
  }

  // 驗證方式
  Widget _buildVerificationMethodRadio(StudentViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '驗證方式:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue, // 與其他標題一致
          ),
        ),
        SizedBox(height: 8), // 標題與選項之間的間距
        RadioListTile<String>(
          title: Text(
            'Email',
            style: TextStyle(fontSize: 16),
          ),
          value: 'Email',
          groupValue: model.student?.verificationMethod,
          onChanged: (value) {
            if (value != null) {
              model.updateStudentInfo('verificationMethod', value);
            }
          },
          activeColor: Colors.blue, // 選中時的顏色
          contentPadding: EdgeInsets.symmetric(horizontal: 0), // 調整內邊距
        ),
        RadioListTile<String>(
          title: Text(
            '手機',
            style: TextStyle(fontSize: 16),
          ),
          value: '手機',
          groupValue: model.student?.verificationMethod,
          onChanged: (value) {
            if (value != null) {
              model.updateStudentInfo('verificationMethod', value);
            }
          },
          activeColor: Colors.blue, // 選中時的顏色
          contentPadding: EdgeInsets.symmetric(horizontal: 0), // 調整內邊距
        ),
      ],
    );
  }
}
