import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sandys_food_express/constants.dart';
import 'package:sandys_food_express/common/errors/http-response-error.dart';
import 'package:sandys_food_express/service-locator.dart';
import 'package:sandys_food_express/services/secure-storage.dart';

class S3Service {
  final _dio = Dio();
  final SecureStorage _secureStorage = locator<SecureStorage>();

  Future<String> uploadFoodPictureToS3(
      String? filename, String filePath) async {
    try {
      String accessToken = await _secureStorage.readSecureData('accessToken');
      _dio.options.headers['Authorization'] = 'Bearer $accessToken';

      var generateUploadUrlHttpResponse = await _dio.post(
          '$apiHostEndpoint/menu/foods/upload-url',
          data: {'filename': filename});
      var generateUploadUrlHttpResponseBody =
          generateUploadUrlHttpResponse.data;

      String s3UploadUrl = generateUploadUrlHttpResponseBody['data']['url'];
      FormData s3UploadFormData = FormData.fromMap({
        "key": generateUploadUrlHttpResponseBody['data']['fields']['key'],
        "bucket": generateUploadUrlHttpResponseBody['data']['fields']['bucket'],
        "X-Amz-Algorithm": generateUploadUrlHttpResponseBody['data']['fields']
            ['X-Amz-Algorithm'],
        "X-Amz-Credential": generateUploadUrlHttpResponseBody['data']['fields']
            ['X-Amz-Credential'],
        "X-Amz-Date": generateUploadUrlHttpResponseBody['data']['fields']
            ['X-Amz-Date'],
        "Policy": generateUploadUrlHttpResponseBody['data']['fields']['Policy'],
        "X-Amz-Signature": generateUploadUrlHttpResponseBody['data']['fields']
            ['X-Amz-Signature'],
        "Content-Type": generateUploadUrlHttpResponseBody['data']['fields']
            ['Content-Type'],
        "file": await MultipartFile.fromFile(filePath, filename: filename),
      });

      _dio.options.headers['Authorization'] = '';
      await _dio.post(s3UploadUrl, data: s3UploadFormData);

      return generateUploadUrlHttpResponseBody['data']['fields']['key'];
    } on DioError catch (e) {
      throw new HttpResponseError(
          errorCode: e.response?.data['error']['code'],
          message: e.response?.data['error']['message']);
    } on SocketException {
      throw new HttpResponseError(
          errorCode: 'NO_INTERNET_CONNECTION',
          message:
              'No internet connection. Please check your connection and try again later.');
    }
  }
}
