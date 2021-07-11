import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sandys_food_express/common/errors/handle_dio_errors.dart';
import 'package:sandys_food_express/constants.dart';
import 'package:sandys_food_express/common/errors/http_response_error.dart';

class AuthService {
  final _dio = Dio();

  Future<dynamic> signIn(String email, String password) async {
    try {
      var httpResponse = await this._dio.post(
        '$apiHostEndpoint/sign-in',
        data: {"email": email, "password": password},
      );
      var httpResponseBody = httpResponse.data;

      return httpResponseBody['data'];
    } on DioError catch (e) {
      handleDioErrors(e);
    }
  }

  Future<dynamic> signUp(
      String name, String email, String address, String password) async {
    try {
      var httpResponse = await this._dio.post(
        '$apiHostEndpoint/sign-up',
        data: {
          "name": name,
          "email": email,
          "address": address,
          "password": password,
        },
      );
      var httpResponseBody = httpResponse.data;

      return httpResponseBody['data'];
    } on DioError catch (e) {
      handleDioErrors(e);
    }
  }
}
