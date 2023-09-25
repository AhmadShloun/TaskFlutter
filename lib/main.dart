import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_flutter/binding/initialbinding.dart';
import 'package:task_flutter/core/class/StatusOverLayout.dart';
import 'package:task_flutter/core/functions/over_layout_style.dart';
import 'package:task_flutter/core/services/services.dart';
import 'package:task_flutter/routes.dart';

void main() async {
  overLayoutStyle(style:StatusLayout.dark );

  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Flutter',
      initialBinding: InitialBinding(),
      getPages: routes,
    );
  }
}
