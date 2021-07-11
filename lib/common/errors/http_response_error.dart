class HttpResponseError {
  final String errorCode;
  final String message;

  HttpResponseError(
      {errorCode = 'INTERNAL_SERVER_ERROR',
      message = 'Something went wrong please try again.'})
      : errorCode = errorCode,
        message = message;
}
