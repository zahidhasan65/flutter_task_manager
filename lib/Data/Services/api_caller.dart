import 'dart:convert';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:task_manager/controller/auth_controller.dart';

class ApiCaller {

  static final Logger _logger = Logger();

  static Future<ApiResponse> getRequest({required String url}) async {

    try {

      Uri uri = Uri.parse(url);

      _logRequest(url);

      Response response = await get(uri, headers: { 'token': AuthController.userToken?? ''}
      );

      _logResponse(uri.toString(), response);

      final decodedData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ApiResponse(
          isSuccess: true,
          responseCode: response.statusCode,
          responseData: decodedData,
        );
      }

      return ApiResponse(
        isSuccess: false,
        responseCode: response.statusCode,
        responseData: decodedData,
      );

    } catch (e) {

      return ApiResponse(
        isSuccess: false,
        responseCode: -1,
        responseData: null,
        errorMsg: "Something went wrong",
      );

    }
  }

  static Future<ApiResponse> postRequest({
    required String url,
    required Map<String, dynamic> body,
  }) async {

    try {

      Uri uri = Uri.parse(url);

      _logRequest(url, body: body);

      Response response = await post(
        uri,
        headers: {'Content-Type': 'application/json',
        'token': AuthController.userToken?? ''},

        body: jsonEncode(body),
      );

      _logResponse(uri.toString(), response);

      final decodedData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return ApiResponse(
          isSuccess: true,
          responseCode: response.statusCode,
          responseData: decodedData,
        );
      }

      return ApiResponse(
        isSuccess: false,
        responseCode: response.statusCode,
        responseData: decodedData,
      );

    } catch (e) {

      return ApiResponse(
        isSuccess: false,
        responseCode: -1,
        responseData: null,
        errorMsg: "Something went wrong",
      );

    }
  }

  static void _logRequest(String url, {Map<String, dynamic>? body}) {
    _logger.i(
      'Url = $url\n'
          'Request Body = $body',
    );
  }

  static void _logResponse(String url, Response response) {
    _logger.i(
      'Url = $url\n'
          'StatusCode = ${response.statusCode}\n'
          'Data = ${response.body}',
    );
  }
}

class ApiResponse {

  final bool isSuccess;
  final int responseCode;
  final dynamic responseData;
  final String? errorMsg;

  ApiResponse({
    required this.isSuccess,
    required this.responseCode,
    required this.responseData,
    this.errorMsg,
  });

}