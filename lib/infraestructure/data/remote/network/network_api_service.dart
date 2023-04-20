import 'dart:convert';
import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:the_cats_app/infraestructure/data/remote/error/network_error.dart';
import 'package:the_cats_app/infraestructure/data/remote/network/base_api_service.dart';

class NetworkApiService extends BaseApiService {
  static const int timeOutseconds = 180;


  @override
  Future<Either<NetworkException, dynamic>> getResponse(String url) async {
    final response = await http.get(Uri.parse(url));
    return returnResponse(response, true);
  }

  @override
  Future<Either<NetworkException, dynamic>> postResponse(
      String url, Object jsonBody,
      {Map<String, String> headers = const {}}) async {
    var response = await http
        .post(Uri.parse(url), body: jsonBody, headers: headers)
        .timeout(const Duration(seconds: timeOutseconds));

    return (returnResponse(response, true));
  }

  

  Either<NetworkException, dynamic> returnResponse(
      http.Response response, bool isJson) {
    if (response.contentLength == 0) {
      return Left(
          FetchDataException('Error occured while communication with server'));
    }
    switch (response.statusCode) {
      case 200:
      case 201:
        if (isJson) {
          Object responseJson = jsonDecode(response.body);
          return Right(responseJson);
        } else {
          return Right(response.bodyBytes);
        }
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        if (isJson) {
          return Left(BadRequestException(responseJson['message']));
        } else {
          var error =
              'Error occured while communication with server with status code : ${response.statusCode}, message: ${response.body}';

          return Left(BadRequestException(error));
        }

      case 401:
      case 403:
        dynamic responseJson = jsonDecode(response.body);
        Get.printError(info: responseJson);

        return Left(BadRequestException(responseJson['message']));
      case 404:
        dynamic responseJson = jsonDecode(response.body);
        Get.printError(info: responseJson.toString());

        return Left(BadRequestException(responseJson['message']));
      case 500:
        dynamic responseJson = jsonDecode(response.body);
        Get.printError(info: responseJson);
        return Left(BadRequestException(responseJson['message']));
      case 502:
        dynamic responseJson = jsonDecode(response.body);
        Get.printError(info: responseJson);
        return Left(BadGateway(
            "Error occured while communication with server with status code : ${response.statusCode}"));
      default:
        return Left(FetchDataException(
            'Error occured while communication with server'
            ' with status code : ${response.statusCode}, message: ${response.body}'));
    }
  }
}
