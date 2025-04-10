// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:zhi_duo_duo/router/custom_router/empty_router.dart' as _i1;
import 'package:zhi_duo_duo/ui/pages/example_view/example_view.dart' as _i2;
import 'package:zhi_duo_duo/ui/pages/sign_up_view.dart' as _i3;
import 'package:zhi_duo_duo/ui/pages/start_view.dart' as _i4;
import 'package:zhi_duo_duo/ui/pages/student_registration_page.dart' as _i5;
import 'package:zhi_duo_duo/ui/pages/student_review_page.dart' as _i6;

/// generated route for
/// [_i1.EmptyRouterPage]
class EmptyRouter extends _i7.PageRouteInfo<void> {
  const EmptyRouter({List<_i7.PageRouteInfo>? children})
    : super(EmptyRouter.name, initialChildren: children);

  static const String name = 'EmptyRouter';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i1.EmptyRouterPage();
    },
  );
}

/// generated route for
/// [_i2.ExampleView]
class ExampleRoute extends _i7.PageRouteInfo<void> {
  const ExampleRoute({List<_i7.PageRouteInfo>? children})
    : super(ExampleRoute.name, initialChildren: children);

  static const String name = 'ExampleRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i2.ExampleView();
    },
  );
}

/// generated route for
/// [_i3.SignUpView]
class SignUpRoute extends _i7.PageRouteInfo<void> {
  const SignUpRoute({List<_i7.PageRouteInfo>? children})
    : super(SignUpRoute.name, initialChildren: children);

  static const String name = 'SignUpRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return _i3.SignUpView();
    },
  );
}

/// generated route for
/// [_i4.StartView]
class StartRoute extends _i7.PageRouteInfo<void> {
  const StartRoute({List<_i7.PageRouteInfo>? children})
    : super(StartRoute.name, initialChildren: children);

  static const String name = 'StartRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return _i4.StartView();
    },
  );
}

/// generated route for
/// [_i5.StudentRegistrationPage]
class StudentRegistrationPage extends _i7.PageRouteInfo<void> {
  const StudentRegistrationPage({List<_i7.PageRouteInfo>? children})
    : super(StudentRegistrationPage.name, initialChildren: children);

  static const String name = 'StudentRegistrationPage';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i5.StudentRegistrationPage();
    },
  );
}

/// generated route for
/// [_i6.StudentReviewPage]
class StudentReviewPage extends _i7.PageRouteInfo<void> {
  const StudentReviewPage({List<_i7.PageRouteInfo>? children})
    : super(StudentReviewPage.name, initialChildren: children);

  static const String name = 'StudentReviewPage';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return _i6.StudentReviewPage();
    },
  );
}
