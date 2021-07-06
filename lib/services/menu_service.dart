import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sandys_food_express/constants.dart';
import 'package:sandys_food_express/common/errors/http_response_error.dart';
import 'package:sandys_food_express/service_locator.dart';
import 'package:sandys_food_express/services/secure_storage.dart';

class MenuService {
  final Dio _dio = Dio();
  final SecureStorage _secureStorage = locator<SecureStorage>();

  Future<List<dynamic>> getFoods() async {
    String accessToken = await SecureStorage().readSecureData('accessToken');
    _dio.options.headers['Authorization'] = 'Bearer $accessToken';
    var httpResponse = await this._dio.get('$apiHostEndpoint/menu/foods');
    var httpResponseBody = httpResponse.data;

    return httpResponseBody['data'];
  }

  Future<dynamic> addFood(String name, double price, String pictureKey) async {
    String accessToken = await _secureStorage.readSecureData('accessToken');
    _dio.options.headers['Authorization'] = 'Bearer $accessToken';

    var addFoodHttpResponse = await this._dio.post(
      '$apiHostEndpoint/menu/foods',
      data: {
        'name': name,
        'price': price,
        'picture': pictureKey,
      },
    );
    var addFoodHttpResponseBody = addFoodHttpResponse.data;

    return addFoodHttpResponseBody;
  }

  Future<void> deleteFood(int id) async {
    String accessToken = await _secureStorage.readSecureData('accessToken');
    _dio.options.headers['Authorization'] = 'Bearer $accessToken';

    var httpResponse =
        await this._dio.delete('$apiHostEndpoint/menu/foods/$id');
    var httpResponseBody = httpResponse.data;
  }
}
