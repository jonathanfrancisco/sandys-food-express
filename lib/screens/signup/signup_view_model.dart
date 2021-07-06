import 'package:flutter/material.dart';
import 'package:sandys_food_express/common/errors/http_response_error.dart';
import 'package:sandys_food_express/service_locator.dart';
import 'package:sandys_food_express/services/auth_service.dart';

enum ViewState { Idle, Busy }

class SignUpViewModel extends ChangeNotifier {
  final AuthService _authService = locator<AuthService>();

  ViewState _state = ViewState.Idle;
  bool _obscurePasswordField = false;
  String? _successMessage;
  String? _errorCode;
  String? _errorMessage = 'Something went wrong please try again.';

  ViewState get state => _state;
  bool get obscurePasswordField => _obscurePasswordField;
  String? get successMessage => _successMessage;
  String? get errorCode => _errorCode;
  String? get errorMessage => _errorMessage;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  String? isValidName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Name is required';
    }

    return null;
  }

  String? isValidEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }

    return null;
  }

  String? isValidAddress(String? address) {
    if (address == null || address.isEmpty) {
      return 'Address is required';
    }

    return null;
  }

  String? isValidPassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }

    return null;
  }

  void toggleObscurePasswordField() {
    _obscurePasswordField = !_obscurePasswordField;
    notifyListeners();
  }

  Future<bool> signUp(
    String name,
    String email,
    String address,
    String password,
  ) async {
    setState(ViewState.Busy);

    try {
      var result = await _authService.signUp(name, email, address, password);

      _successMessage =
          'You have successfully signed-up for an account! You may now login';

      return true;
    } on HttpResponseError catch (e) {
      _errorCode = e.errorCode;
      _errorMessage = e.message;
    }

    setState(ViewState.Idle);
    return false;
  }
}
