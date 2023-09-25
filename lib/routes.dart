import 'package:get/get.dart';
import 'package:task_flutter/core/constant/routes.dart';
import 'package:task_flutter/core/middleware/mymiddleware.dart';
import 'package:task_flutter/view/screen/createpost.dart';
import 'package:task_flutter/view/screen/homescreen.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(name: AppRoute.homepage, page: () => const HomeScreen()),
  GetPage(name: AppRoute.createpost, page: () => const CreatePostScreen()),
];
