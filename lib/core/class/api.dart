// get post delete  put methode

// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:mas_app/core/class/status_request.dart';

import '../function/custom_exception.dart';
import '../function/handle_exception.dart';

class Api {
  Future<Either<StatuesRequest, dynamic>> getData(
      String linkUrl, Map<String, String>? headers) async {
    final url = linkUrl;

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      //  .timeout(const Duration(seconds: 10) );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        return right(data);
      } else if (response.statusCode == 400) {
        throw BadRequestException();
      } else if (response.statusCode == 401) {
        throw UnauthorizedException();
      } else if (response.statusCode == 404) {
        return left(StatuesRequest.serverException);
      } else if (response.statusCode == 403) {
        throw ForbiddenException();
      } else if (response.statusCode == 500) {
        print(response.body);
        return left(StatuesRequest.serverError);
      } else if (response.statusCode == 409) {
        throw ConflictException();
      } else {
        return left(StatuesRequest.defaultException);
      }
    } on SocketException {
      return left(StatuesRequest.socketException);
    } on http.ClientException {
      return left(StatuesRequest.clientException);
    } on TimeoutException {
      return left(StatuesRequest.timeoutException);
    } catch (e) {
      return left(handleException(e));
    }
  }

  Future<Either<StatuesRequest, dynamic>> postData(
      String linkUrl, Map<String, String>? headers, Map data) async {
    final url = linkUrl;

    // final dataPost = jsonEncode(data);
    try {
      final response = await http
          .post(Uri.parse(url), headers: headers, body: data)
          .timeout(const Duration(seconds: 20));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        return right(data);
      } else if (response.statusCode == 422) {
        final data = jsonDecode(response.body);
        print(data);
        return left(StatuesRequest.unprocessableException);
      } else if (response.statusCode == 400) {
        throw BadRequestException();
      } else if (response.statusCode == 401) {
        throw UnauthorizedException();
      } else if (response.statusCode == 404) {
        return left(StatuesRequest.serverException);
      } else if (response.statusCode == 403) {
        throw ForbiddenException();
      } else if (response.statusCode == 500) {
        return left(StatuesRequest.serverError);
      } else if (response.statusCode == 409) {
        throw ConflictException();
      } else {
        print(response.statusCode);
        return left(StatuesRequest.defaultException);
      }
    } on SocketException {
      return left(StatuesRequest.socketException);
    } on http.ClientException {
      return left(StatuesRequest.clientException);
    } on TimeoutException {
      return left(StatuesRequest.timeoutException);
    } catch (e) {
      return left(handleException(e));
    }
  }

  Future<Either<StatuesRequest, dynamic>> updateData(
      String linkUrl, Map<String, String>? headers, Map data) async {
    final url = linkUrl;

    // final dataPost = jsonEncode(data);
    try {
      final response = await http
          .put(Uri.parse(url), headers: headers, body: data)
          .timeout(const Duration(seconds: 20));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        return right(data);
      } else if (response.statusCode == 400) {
        throw BadRequestException();
      } else if (response.statusCode == 401) {
        throw UnauthorizedException();
      } else if (response.statusCode == 404) {
        return left(StatuesRequest.serverException);
      } else if (response.statusCode == 403) {
        throw ForbiddenException();
      } else if (response.statusCode == 500) {
        return left(StatuesRequest.serverError);
      } else if (response.statusCode == 409) {
        throw ConflictException();
      } else {
        return left(StatuesRequest.defaultException);
      }
    } on SocketException {
      return left(StatuesRequest.socketException);
    } on http.ClientException {
      return left(StatuesRequest.clientException);
    } on TimeoutException {
      return left(StatuesRequest.timeoutException);
    } catch (e) {
      return left(handleException(e));
    }
  }

  Future<Either<StatuesRequest, dynamic>> deleteData(
      String linkUrl, Map<String, String>? headers) async {
    final url = linkUrl;

    try {
      final response = await http
          .delete(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        return right(data);
      } else if (response.statusCode == 400) {
        throw BadRequestException();
      } else if (response.statusCode == 401) {
        throw UnauthorizedException();
      } else if (response.statusCode == 404) {
        return left(StatuesRequest.serverException);
      } else if (response.statusCode == 403) {
        throw ForbiddenException();
      } else if (response.statusCode == 500) {
        return left(StatuesRequest.serverError);
      } else if (response.statusCode == 409) {
        throw ConflictException();
      } else {
        return left(StatuesRequest.defaultException);
      }
    } on SocketException {
      return left(StatuesRequest.socketException);
    } on http.ClientException {
      return left(StatuesRequest.clientException);
    } on TimeoutException {
      return left(StatuesRequest.timeoutException);
    } catch (e) {
      return left(handleException(e));
    }
  }

//post data with file

  postRequestwithfile(String url, Map data, File? image, String token) async {
    //لو هترفع داتا ومعاها ملف
    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));

      request.headers['Authorization'] = 'Bearer $token';
      print("   img   ????  $image");
      if (image != null) {
        var stream = http.ByteStream(image.openRead());

        stream.cast();

        request.files
            .add(await http.MultipartFile.fromPath("avatar", image.path));
      } else {}
      data.forEach((key, value) {
        request.fields[key] = value;
      });

      var myrequest = await request.send();

      var response = await http.Response.fromStream(myrequest);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        return right(data);
      } else if (response.statusCode == 400) {
        throw BadRequestException();
      } else if (response.statusCode == 401) {
        throw UnauthorizedException();
      } else if (response.statusCode == 404) {
        return left(StatuesRequest.serverException);
      } else if (response.statusCode == 403) {
        throw ForbiddenException();
      } else if (response.statusCode == 500) {
        return left(StatuesRequest.serverError);
      } else if (response.statusCode == 409) {
        throw ConflictException();
      } else {
        return left(StatuesRequest.defaultException);
      }
    } on SocketException {
      return left(StatuesRequest.socketException);
    } on http.ClientException {
      return left(StatuesRequest.clientException);
    } on TimeoutException {
      return left(StatuesRequest.timeoutException);
    } catch (e) {
      return left(handleException(e));
    }
  }
}
