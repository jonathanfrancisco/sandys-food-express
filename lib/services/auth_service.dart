import 'dart:io';

import 'package:dio/dio.dart';
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
      throw new HttpResponseError(
        errorCode: e.response?.data['error']['code'],
        message: e.response?.data['error']['message'],
      );
    } on SocketException {} catch (e) {
      throw new HttpResponseError(
          errorCode: 'NO_INTERNET_CONNECTION',
          message:
              'No internet connection. Please check your connection and try again later.');
    }

    throw new HttpResponseError(
        message: 'Something went wrong please try again.');
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
      throw new HttpResponseError(
        errorCode: e.response?.data['error']['code'],
        message: e.response?.data['error']['message'],
      );
    } on SocketException {} catch (e) {
      throw new HttpResponseError(
          errorCode: 'NO_INTERNET_CONNECTION',
          message:
              'No internet connection. Please check your connection and try again later.');
    }

    throw new HttpResponseError(
        message: 'Something went wrong please try again.');
  }
}
