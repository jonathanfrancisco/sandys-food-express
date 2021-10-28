import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sandys_food_express/common/errors/http-response-error.dart';
import 'package:sandys_food_express/models/Food.dart';
import 'package:sandys_food_express/service-locator.dart';
import 'package:sandys_food_express/services/menu-service.dart';
import 'package:sandys_food_express/services/s3-service.dart';

enum ViewState { Idle, Busy }

class MenuViewModel extends ChangeNotifier {
  final MenuService _menuService = locator<MenuService>();
  final S3Service _s3service = locator<S3Service>();

  ViewState _state = ViewState.Idle;
  bool _isMenuTableLoading = false;
  String errorCode = '';
  String errorMessage = '';
  List<Food> _foods = [];
  List<int> _selectedFoodIds = [];

  MenuViewModel() {
    loadFoods();
  }

  ViewState get state => _state;
  bool get isMenuTableLoading => _isMenuTableLoading;
  String get menuTableErrorCode => errorCode;
  String get menuTableErrorMessage => errorMessage;
  List<Food> get foods => _foods;
  List<int> get selectedFoodIds => _selectedFoodIds;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  Future<void> loadFoods({String query = ''}) async {
    _isMenuTableLoading = true;
    notifyListeners();
    try {
      _foods = await _menuService.getFoods(query);
    } on HttpResponseError catch (e) {
      errorCode = e.errorCode;
      errorMessage = e.message;
    }

    _isMenuTableLoading = false;
    notifyListeners();
  }

  Future<void> addFood(
      String name, double price, String? filename, String filepath) async {
    String pictureKey =
        await _s3service.uploadFoodPictureToS3(filename, filepath);
    await _menuService.addFood(name, price, pictureKey);
  }

  Future<bool> deleteFood(int id) async {
    try {
      await _menuService.deleteFood(id);
      return true;
    } on HttpResponseError catch (e) {
      errorCode = e.errorCode;
      errorMessage = e.message;
      return false;
    }
  }

  Future<void> createScheduledMenu(
    List<int> selectedFoodIds,
    DateTime scheduledDateTime,
  ) async {
    await _menuService.createScheduledMenu(selectedFoodIds, scheduledDateTime);
  }

  void onMenuFoodTableRowSelectToggle(int foodId) {
    if (_selectedFoodIds.indexOf(foodId) == -1) {
      _selectedFoodIds.add(foodId);
    } else {
      _selectedFoodIds.remove(foodId);
    }

    notifyListeners();
  }

  void onMenuFoodTableRowSelectAllToggle(List<int> availableFoodIds) {
    if (_selectedFoodIds.length == availableFoodIds.length) {
      _selectedFoodIds.clear();
    } else {
      availableFoodIds.forEach((foodId) {
        if (_selectedFoodIds.indexOf(foodId) == -1) {
          _selectedFoodIds.add(foodId);
        }
      });
    }
    notifyListeners();
  }
}
