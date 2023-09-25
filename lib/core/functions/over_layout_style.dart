import 'package:flutter/services.dart';
import 'package:task_flutter/core/class/StatusOverLayout.dart';
import 'package:task_flutter/core/constant/color.dart';

overLayoutStyle({required StatusLayout style}) {
  if (style == StatusLayout.light) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColor.transparent, // Color for Android
        statusBarIconBrightness: Brightness.light,
      ),
    );
  } else {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColor.transparent, // Color for Android
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }
}
