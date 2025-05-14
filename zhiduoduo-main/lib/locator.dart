import 'package:get_it/get_it.dart';
import 'package:zhi_duo_duo/core/services/api_service.dart';
import 'package:zhi_duo_duo/viewmodels/base_view_model.dart';
import 'package:zhi_duo_duo/viewmodels/development_view_model/development_view_model.dart';
import 'package:zhi_duo_duo/viewmodels/example_view_model/exmple_view_model.dart';
import 'package:zhi_duo_duo/viewmodels/global_view_model.dart';
import 'package:zhi_duo_duo/viewmodels/sign_up_view_model.dart';
import 'package:zhi_duo_duo/viewmodels/start_view_model.dart';
import 'package:zhi_duo_duo/viewmodels/student_approve_view_model.dart';
import 'package:zhi_duo_duo/viewmodels/student_view_model.dart';
import 'package:zhi_duo_duo/viewmodels/coursesearch_view_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => GlobalViewModel());
  locator.registerLazySingleton(() => BaseViewModel());
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => ExampleViewModel());
  locator.registerLazySingleton(() => DevelopmentViewModel());
  locator.registerLazySingleton(() => StartViewModel());
  locator.registerLazySingleton(() => SignUpViewModel());
  locator.registerLazySingleton(() => StudentViewModel());
  locator.registerLazySingleton(() => StudentApproveModel());
  locator.registerLazySingleton(() => CourseSearchViewModel());
}
