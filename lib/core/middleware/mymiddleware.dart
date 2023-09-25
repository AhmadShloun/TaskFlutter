import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_flutter/core/constant/routes.dart';
import 'package:task_flutter/core/services/services.dart';

class MyMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;
  MyServices myServices = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    if (myServices.sharedPreferences.getString("itemData") !="") {
      return const RouteSettings(name: AppRoute.homepage);
    }
    else
      {
        print("asdasdasdasdasdasdasd");
      }

    return null;
  }
}
