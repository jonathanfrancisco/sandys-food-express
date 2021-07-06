import 'package:flutter/material.dart';
import 'package:sandys_food_express/service_locator.dart';
import 'package:sandys_food_express/services/secure_storage.dart';

enum ViewState { Idle, Busy }

class HomeViewModel extends ChangeNotifier {
  final SecureStorage _secureStorage = locator<SecureStorage>();

  ViewState _state = ViewState.Idle;
  String _currentActiveDrawerItemTitle = 'QUEUE'; // DEFAULT

  ViewState get state => _state;
  String get currentActiveDrawerItemTitle => _currentActiveDrawerItemTitle;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  void setCurrentActiveDrawerItemTitle(String drawerItemTitle) {
    _currentActiveDrawerItemTitle = drawerItemTitle;
    notifyListeners();
  }
}
