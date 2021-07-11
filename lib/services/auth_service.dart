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
      if (e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectTimeout) {
        throw new HttpResponseError(
            errorCode: 'NO_INTERNET_CONNECTION',
            message:
                'No internet connection. Please verify and check your connection and try again later.');
      }

      if (e.type == DioErrorType.response) {
        throw new HttpResponseError(
          errorCode: e.response?.data['error']['code'],
          message: e.response?.data['error']['message'],
        );
      }

      if (e.type == DioErrorType.other) {
        throw new HttpResponseError(
          errorCode: 'OTHER_ERROR',
          message: 'Problem connecting to the server. Please try again.',
        );
      }

      throw new HttpResponseError();
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
      if (e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.connectTimeout) {
        throw new HttpResponseError(
            errorCode: 'NO_INTERNET_CONNECTION',
            message:
                'No internet connection. Please verify and check your connection and try again later.');
      }

      if (e.type == DioErrorType.response) {
        throw new HttpResponseError(
          errorCode: e.response?.data['error']['code'],
          message: e.response?.data['error']['message'],
        );
      }

      if (e.type == DioErrorType.other) {
        throw new HttpResponseError(
          errorCode: 'OTHER_ERROR',
          message: 'Problem connecting to the server. Please try again.',
        );
      }

      throw new HttpResponseError();
    }
  }
}
