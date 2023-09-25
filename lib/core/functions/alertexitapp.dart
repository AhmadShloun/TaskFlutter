import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_flutter/core/constant/color.dart';

Future<bool> alertExitApp() {
  Get.defaultDialog(
    title: 'warning'.tr,
    middleText: "Do you want to exit the application ?".tr,
    actions: [
      //Exit app
      ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all(AppColor.primaryColor)),
          onPressed: () {
            exit(0);
          },
          child: Text("ok".tr)),
      // Cancel
      ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all(AppColor.primaryColor)),
          onPressed: () {
            Get.back();
          },
          child: Text("cancel".tr)),
    ],
  );
  return Future.value(true);
}
