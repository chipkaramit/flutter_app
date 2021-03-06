import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'custom_exception.dart';

class ApiProvider {
  final String _baseUrl = "http://10.0.2.2:8080/Darwish/"; // Android emulator
  //final String _baseUrl = "http://192.168.43.181:8080/Darwish/"; // Mobile emulator

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http.get(_baseUrl + url);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  //---- post method
  Future<dynamic> post(String url, {Map headers, body, encoding}) async {
    var responseJson;
    try {
      return http
          .post(_baseUrl + url,
              body: body, headers: headers, encoding: encoding)
          .then((http.Response response) {
        responseJson = _response(response);
        return responseJson;
      });
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    //return responseJson;
  }
}
