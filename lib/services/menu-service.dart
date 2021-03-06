import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sandys_food_express/common/errors/handle-dio-errors.dart';
import 'package:sandys_food_express/constants.dart';
import 'package:sandys_food_express/models/Food.dart';
import 'package:sandys_food_express/service-locator.dart';
import 'package:sandys_food_express/services/secure-storage.dart';

class MenuService {
  final Dio _dio = Dio();
  final SecureStorage _secureStorage = locator<SecureStorage>();

  Future<List<Food>> getFoods(String query) async {
    String accessToken = await SecureStorage().readSecureData('accessToken');
    _dio.options.headers['Authorization'] = 'Bearer $accessToken';

    try {
      var httpResponse = await this._dio.get(
        '$apiHostEndpoint/menu/foods',
        queryParameters: {'q': query},
      );

      List<dynamic> parsedJsonFoods = httpResponse.data['data'];
      List<Food> foods =
          List<Food>.from(parsedJsonFoods.map((i) => Food.fromJson(i)));

      return foods;
    } on DioError catch (e) {
      return handleDioErrors(e);
    }
  }

  Future<dynamic> addFood(String name, double price, String pictureKey) async {
    String accessToken = await _secureStorage.readSecureData('accessToken');
    _dio.options.headers['Authorization'] = 'Bearer $accessToken';

    try {
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
    } on DioError catch (e) {
      handleDioErrors(e);
    }
  }

  Future<void> deleteFood(int id) async {
    String accessToken = await _secureStorage.readSecureData('accessToken');
    _dio.options.headers['Authorization'] = 'Bearer $accessToken';
    try {
      await this._dio.delete('$apiHostEndpoint/menu/foods/$id');
    } on DioError catch (e) {
      print(e.toString());
      handleDioErrors(e);
    }
  }

  Future<void> createScheduledMenu(
    List<int> selectedFoodIds,
    DateTime scheduledDateTime,
  ) async {
    String accessToken = await _secureStorage.readSecureData('accessToken');
    _dio.options.headers['Authorization'] = 'Bearer $accessToken';

    try {
      var response = await this._dio.post(
        '$apiHostEndpoint/menu',
        data: {
          'foodIds': selectedFoodIds,
          'scheduledAt': scheduledDateTime.toString(),
        },
      );

      print('response: ' + response.toString());
    } on DioError catch (e) {
      print(e.toString());
      handleDioErrors(e);
    }
  }
}
