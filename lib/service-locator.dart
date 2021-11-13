import 'package:get_it/get_it.dart';
import 'package:sandys_food_express/screens/home/home-view-model.dart';
import 'package:sandys_food_express/screens/menu/menu-view-model.dart';
import 'package:sandys_food_express/screens/orders/orders-tab-add-order-view-model.dart';
import 'package:sandys_food_express/screens/signin/signin-view-model.dart';
import 'package:sandys_food_express/screens/signup/signup-view-model.dart';
import 'package:sandys_food_express/services/auth-service.dart';
import 'package:sandys_food_express/services/menu-service.dart';
import 'package:sandys_food_express/services/s3-service.dart';
import 'package:sandys_food_express/services/secure-storage.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // View Models
  locator.registerLazySingleton<SignInViewModel>(() => SignInViewModel());
  locator.registerLazySingleton<SignUpViewModel>(() => SignUpViewModel());
  locator.registerLazySingleton<HomeViewModel>(() => HomeViewModel());
  locator.registerFactory<MenuViewModel>(() => MenuViewModel());
  locator.registerFactory<OrdersTabAddOrderViewModel>(
      () => OrdersTabAddOrderViewModel());

  // Services
  locator.registerLazySingleton<SecureStorage>(() => SecureStorage());
  locator.registerLazySingleton<AuthService>(() => AuthService());
  locator.registerLazySingleton<MenuService>(() => MenuService());
  locator.registerLazySingleton<S3Service>(() => S3Service());
}
