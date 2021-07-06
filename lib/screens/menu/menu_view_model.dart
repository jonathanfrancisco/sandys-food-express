import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sandys_food_express/service_locator.dart';
import 'package:sandys_food_express/services/menu_service.dart';
import 'package:sandys_food_express/services/s3_service.dart';
import 'package:sandys_food_express/services/secure_storage.dart';

enum ViewState { Idle, Busy }

class MenuViewModel extends ChangeNotifier {
  final MenuService _menuService = locator<MenuService>();
  final SecureStorage _secureStorage = locator<SecureStorage>();
  final S3Service _s3service = locator<S3Service>();

  ViewState _state = ViewState.Idle;
  bool _isMenuTableLoading = false;
  List<dynamic> _foods = [];

  MenuViewModel() {
    loadFoods();
  }

  ViewState get state => _state;
  bool get isMenuTableLoading => _isMenuTableLoading;
  List<dynamic> get foods => _foods;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  Future<void> loadFoods() async {
    _isMenuTableLoading = true;
    notifyListeners();

    _foods = await _menuService.getFoods();

    _isMenuTableLoading = false;
    notifyListeners();
  }

  Future<void> addFood(
      String name, double price, String? filename, String filepath) async {
    String pictureKey =
        await _s3service.uploadFoodPictureToS3(filename, filepath);
    var response = await _menuService.addFood(name, price, pictureKey);
    debugPrint(response.toString());
  }

  Future<void> deleteFood(int id) async {
    await _menuService.deleteFood(id);
  }
}
