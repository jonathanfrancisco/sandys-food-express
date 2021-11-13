import 'package:flutter/material.dart';
import 'package:sandys_food_express/common/errors/http-response-error.dart';
import 'package:sandys_food_express/models/Food.dart';
import 'package:sandys_food_express/service-locator.dart';
import 'package:sandys_food_express/services/menu-service.dart';

enum ViewState { Idle, Busy }

class OrdersTabAddOrderViewModel extends ChangeNotifier {
  final MenuService _menuService = locator<MenuService>();

  ViewState _state = ViewState.Idle;
  String errorCode = '';
  String errorMessage = '';

  bool _isOrderMenuTableLoading = false;
  List<Food> _foods = [];
  List<int> _selectedFoodIds = [];
  int _availableFoodsCount = 0;
  List<Map> _orders = [];

  ViewState get state => _state;
  bool get isOrderMenuTableLoading => _isOrderMenuTableLoading;
  String get menuTableErrorCode => errorCode;
  String get menuTableErrorMessage => errorMessage;
  List<Food> get foods => _foods;
  List<int> get selectedFoodIds => _selectedFoodIds;
  int get availableFoodsCount => _availableFoodsCount;
  List<Map> get orders => _orders;

  OrdersTabAddOrderViewModel() {
    loadFoods();
  }

  Future<void> loadFoods({String query = ''}) async {
    _isOrderMenuTableLoading = true;
    notifyListeners();
    try {
      _foods = await _menuService.getFoods(query);
      _availableFoodsCount =
          _foods.where((food) => food.isAvailableToday == true).length;
      ;
    } on HttpResponseError catch (e) {
      errorCode = e.errorCode;
      errorMessage = e.message;
    }

    _isOrderMenuTableLoading = false;
    notifyListeners();
  }

  void onMenuFoodTableRowSelectToggle(int foodId) {
    if (_selectedFoodIds.indexOf(foodId) == -1) {
      _selectedFoodIds.add(foodId);

      Food selectedFood = _foods.firstWhere((element) => element.id == foodId);
      _orders.add({
        "id": selectedFood.id,
        "name": selectedFood.name,
        "picture": selectedFood.picture,
        "price": selectedFood.price,
        "quantity": 1,
      });
    } else {
      _selectedFoodIds.remove(foodId);
      _orders.removeWhere((element) => element['id'] == foodId);
    }

    notifyListeners();
  }

  void onMenuFoodTableRowSelectAllToggle(List<int> availableFoodIds) {
    if (_selectedFoodIds.length == availableFoodIds.length) {
      _selectedFoodIds.clear();
      _orders.clear();
    } else {
      availableFoodIds.forEach((foodId) {
        if (_selectedFoodIds.indexOf(foodId) == -1) {
          _selectedFoodIds.add(foodId);
          Food selectedFood =
              _foods.firstWhere((element) => element.id == foodId);
          _orders.add({
            "id": selectedFood.id,
            "name": selectedFood.name,
            "picture": selectedFood.picture,
            "price": selectedFood.price,
            "quantity": 1,
          });
        }
      });
    }
    notifyListeners();
  }

  void onOrderRemove(int foodId) {
    _selectedFoodIds.remove(foodId);
    _orders.removeWhere((element) => element['id'] == foodId);

    notifyListeners();
  }

  void onOrderQuantityIncrease(int foodId) {
    var selectedFood = _orders.firstWhere((element) => element['id'] == foodId);
    selectedFood['quantity'] = selectedFood['quantity'] + 1;

    notifyListeners();
  }

  void onOrderQuantityDecrease(int foodId) {
    var selectedFood = _orders.firstWhere((element) => element['id'] == foodId);
    selectedFood['quantity'] = selectedFood['quantity'] - 1;

    notifyListeners();
  }
}
