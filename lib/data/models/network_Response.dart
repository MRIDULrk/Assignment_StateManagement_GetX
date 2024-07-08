class NetworkResponse {
  final int statusCode;
  final bool isSuccess;
  final dynamic responseData;
  final String? erroMessage;

  NetworkResponse(
      {required this.statusCode,
      required this.isSuccess,
      this.responseData,
      this.erroMessage = 'Something Went Wrong'});
}
