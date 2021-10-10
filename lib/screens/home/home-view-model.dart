import 'package:flutter/material.dart';

enum ViewState { Idle, Busy }

class HomeViewModel extends ChangeNotifier {
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
