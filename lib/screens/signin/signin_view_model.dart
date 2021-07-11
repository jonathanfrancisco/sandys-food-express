import 'package:flutter/foundation.dart';
import 'package:sandys_food_express/service_locator.dart';

import 'package:sandys_food_express/common/errors/http_response_error.dart';

import 'package:sandys_food_express/services/auth_service.dart';
import 'package:sandys_food_express/services/secure_storage.dart';

enum ViewState { Idle, Busy }

class SignInViewModel extends ChangeNotifier {
  final SecureStorage _secureStorage = locator<SecureStorage>();
  final AuthService _authService = locator<AuthService>();

  ViewState _state = ViewState.Idle;
  String? _successMessage;
  String? _errorCode;
  String? _errorMessage;
  bool _obscurePasswordField = true;

  ViewState get state => _state;
  String? get successMessage => _successMessage;
  String? get errorCode => _errorCode;
  String? get errorMessage => _errorMessage;
  bool get obscurePasswordField => _obscurePasswordField;

  void setState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  String? isValidEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }

    return null;
  }

  String? isValidPasssword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }

    return null;
  }

  void toggleObscurePassworField() {
    _obscurePasswordField = !_obscurePasswordField;
    notifyListeners();
  }

  Future<bool> signIn(String email, String password) async {
    setState(ViewState.Busy);

    try {
      var result = await _authService.signIn(email, password);
      _secureStorage.writeSecureData('accessToken', result['accessToken']);

      _successMessage = 'You may login';

      return true;
    } on HttpResponseError catch (e) {
      _errorCode = e.errorCode;
      _errorMessage = e.message;
    }

    setState(ViewState.Idle);
    return false;
  }
}
