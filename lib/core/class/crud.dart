import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:task_flutter/core/class/statusrequest.dart';
import 'package:task_flutter/core/functions/checkinternet.dart';

class Crud extends GetConnect {
  String baseToken = 'Bearer';
  String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vYXBpLm1lZGlhLW5hcy5uZXQvYXBpL3VzZXJzL3YxL2xvZ2luIiwiaWF0IjoxNjk1MTAzMjc1LCJleHAiOjE2OTc1MTUyNzUsIm5iZiI6MTY5NTEwMzI3NSwianRpIjoiMEFlUHJYbHdhYzVldFRucCIsInN1YiI6Ijg2MCIsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.3MArC7a18eeOQ0IRXjpXjD8DvCiYTtI7CmRa0CzmM08";

  Future<Either<StatusRequest, Map>> postData(
      {required String linkUrl, required String data}) async {
    try {
      if (await checkInternet()) {
        var response = await http.post(
          Uri.parse(linkUrl),
          headers: {
            HttpHeaders.authorizationHeader: '$baseToken $token',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
          body: data,
        );
        print("statusCode : ${response.statusCode}");
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = jsonDecode(response.body);
          if (kDebugMode) {
            print("responseBody : $responseBody");
          }
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverFailure);
    }
  }

  Future<Either<StatusRequest, Map>> fetchData({required String linkUrl, required int page,required int limit}) async {
    try {
      if (await checkInternet()) {
        final response = await get(
            "${linkUrl}limit=$limit&page=$page",
            headers: {
              HttpHeaders.authorizationHeader: '$baseToken $token',
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            });
        print("statusCode : ${response.statusCode}");
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responseBody = response.body;
          if (kDebugMode) {
            print("responseBody : $responseBody");
          }
          return Right(responseBody);
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverFailure);
    }
  }
}
