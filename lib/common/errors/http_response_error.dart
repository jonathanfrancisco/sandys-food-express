class HttpResponseError {
  final String? errorCode;
  final String message;

  HttpResponseError({errorCode = 'INTERNAL_SERVER_ERROR', required message})
      : errorCode = errorCode,
        message = message;
}
