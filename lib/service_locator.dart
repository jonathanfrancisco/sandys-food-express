import 'package:get_it/get_it.dart';
import 'package:sandys_food_express/screens/home/home_view_model.dart';
import 'package:sandys_food_express/screens/menu/menu_view_model.dart';
import 'package:sandys_food_express/screens/signin/signin_view_model.dart';
import 'package:sandys_food_express/screens/signup/signup_view_model.dart';
import 'package:sandys_food_express/services/auth_service.dart';
import 'package:sandys_food_express/services/menu_service.dart';
import 'package:sandys_food_express/services/s3_service.dart';
import 'package:sandys_food_express/services/secure_storage.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // View Models
  locator.registerLazySingleton<SignInViewModel>(() => SignInViewModel());
  locator.registerLazySingleton<SignUpViewModel>(() => SignUpViewModel());
  locator.registerLazySingleton<HomeViewModel>(() => HomeViewModel());
  locator.registerLazySingleton<MenuViewModel>(() => MenuViewModel());

  // Services
  locator.registerLazySingleton<SecureStorage>(() => SecureStorage());
  locator.registerLazySingleton<AuthService>(() => AuthService());
  locator.registerLazySingleton<MenuService>(() => MenuService());
  locator.registerLazySingleton<S3Service>(() => S3Service());
}
