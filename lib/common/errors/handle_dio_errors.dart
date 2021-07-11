import 'package:dio/dio.dart';
import 'package:sandys_food_express/common/errors/http_response_error.dart';

handleDioErrors(DioError e) {
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
