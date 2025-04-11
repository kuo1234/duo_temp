import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:zhi_duo_duo/router/app_router.gr.dart';
import 'package:zhi_duo_duo/viewmodels/base_view_model.dart';

class StartViewModel extends BaseViewModel {
  void onStartPressed(BuildContext context) {
    // Use context.router instead of AutoRouter.of(context)
    context.router.push(const StudentRegistrationPage());
  }
  void onreviewPressed(BuildContext context) {
    // Use context.router instead of AutoRouter.of(context)
    context.router.push(const StudentApprove());
  }
}
