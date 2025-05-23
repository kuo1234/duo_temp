import 'package:auto_route/auto_route.dart';
import 'package:zhi_duo_duo/router/app_router.gr.dart';


@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    // 歡迎頁面
    AutoRoute(path: '/start', initial: true, page: StartRoute.page),

    // 註冊頁面
    AutoRoute(path: '/sign-up', page: SignUpRoute.page, children: const []),

    // 填寫資料頁面，內含子路由
    AutoRoute(
      path: '/student-registration',
      page: StudentRegistrationPage.page,
      children: [],
    ),
     AutoRoute(
      path: '/student-approve',
      page: StudentApprove.page,
      children: [],
    ),
    AutoRoute(
      path: '/course-browse',
      page: CourseBrowse.page,
      children: []
    ),
    /* AutoRoute(
      path: '/course-search',
      page: CourseSearch.page,
      children: []
    ), */
      
  ];
}
