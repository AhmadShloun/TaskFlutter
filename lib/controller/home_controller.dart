import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_flutter/core/class/statusrequest.dart';
import 'package:task_flutter/core/constant/routes.dart';
import 'package:task_flutter/core/functions/handlingdatacontroller.dart';
import 'package:task_flutter/core/services/services.dart';
import 'package:task_flutter/data/datasource/remote/home_data.dart';

abstract class HomeController extends GetxController {
  getFetchData();

  saveItemDataToPrefs();

  getItemDataFromPrefs();

  goToCreatePost();

  refreshData();

  reloadData();

  scrollToTop();

  onScroll();

  onRefresh();
}

class HomeControllerImp extends HomeController {
  StatusRequest statusRequest = StatusRequest.none;
  HomeData homeData = HomeData(Get.find());
  MyServices myServices = Get.find();

  int page = 1;
  final int limit = 8;
  RxBool hasMore = true.obs;
  RxMap data = {}.obs;
  RxList itemData = [].obs;
  RxBool reloadBool = false.obs;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    getItemDataFromPrefs();
    super.onInit();
  }

  @override
  getFetchData() async {
    try {
      statusRequest = StatusRequest.loading;
      update();
      var response = await homeData.getFetchDataApi(page, limit);
      statusRequest = handlingData(response);

      if (StatusRequest.success == statusRequest) {
        if (response['status'] == 200 || response['status'] == 201) {
          if (response['data']['total'] < limit) {
            hasMore.value = false;
          }

          for (var newItem in response['data']['items']) {
            // Check if the item already exists in itemData
            bool itemExists = itemData
                .any((existingItem) => existingItem['id'] == newItem['id']);

            // Add the item to itemData if it doesn't already exist
            if (!itemExists) {
              itemData.add(newItem);
            }
          }

          data.addAll(response['data']);
          saveItemDataToPrefs();
          page++;
        } else {
          Get.defaultDialog(title: "Warning", middleText: response['status']);
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    } catch (e) {
      Get.defaultDialog(title: "Warning", middleText: e.toString());
    }
  }

  @override
  Future<void> saveItemDataToPrefs() async {
    try {
      String itemDataJson = jsonEncode(itemData);
      await myServices.sharedPreferences.setString('itemData', itemDataJson);
    } catch (e) {
      if (kDebugMode) {
        print('Error saving itemData to shared preferences: $e');
      }
    }
  }

  @override
  Future<void> getItemDataFromPrefs() async {
    try {
      String? itemDataJson = myServices.sharedPreferences.getString('itemData');

      if (itemDataJson != null) {
        List<dynamic> decodedList = jsonDecode(itemDataJson);
        itemData.assignAll(decodedList);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error retrieving itemData from shared preferences: $e');
      }
    }
  }

  @override
  goToCreatePost() {
    Get.toNamed(AppRoute.createpost);
  }

  @override
  Future refreshData() async {
    page = 1;
    hasMore.value = true;
    data.value.clear();
    itemData.clear();
    reloadBool.value = true;
    // if(dd.value){itemData.clear();}

    await getFetchData();
  }

  @override
  Future reloadData() async {
    reloadBool.value = true;
    page = 1;
    hasMore.value = true;
    data.value.clear();
    // itemData.clear();
    await getFetchData();
  }

  @override
  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(seconds: 1), // Adjust the duration as needed
      curve: Curves.easeInOut,
    );
  }

  @override
  void onScroll() {
    double maxScroll = scrollController.position.maxScrollExtent;
    double currentScroll = scrollController.position.pixels;
    print("$maxScroll   $currentScroll");
    if (maxScroll == currentScroll && hasMore.value) {
      getFetchData();
    }
  }

  @override
  Future onRefresh() async {
    refreshData();
  }
}
