import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:task_flutter/controller/home_controller.dart';
import 'package:task_flutter/core/constant/color.dart';
import 'package:task_flutter/core/functions/alertexitapp.dart';
import 'package:task_flutter/data/model/homemodel/items_model.dart';
import 'package:task_flutter/view/widget/home/custom_newpost.dart';
import 'package:task_flutter/view/widget/home/custom_nodata.dart';
import 'package:task_flutter/view/widget/home/custom_post.dart';

class HomeScreen extends GetView<HomeControllerImp> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    HomeControllerImp controller = Get.put(HomeControllerImp());
    controller.getFetchData();
    controller.scrollController.addListener(controller.onScroll);

    return GetBuilder<HomeControllerImp>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text("Task Flutter"),
            backgroundColor: AppColor.primaryColor,
            actions: controller.itemData.isNotEmpty
                ? [
                    IconButton(
                      icon: const Icon(Icons.home_outlined),
                      onPressed: controller.scrollToTop,
                    ),
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () {
                        controller.refreshData();
                      },
                    ),
                  ]
                : null,
          ),
          body: WillPopScope(
            onWillPop: alertExitApp,
            child: controller.reloadBool.value || controller.itemData.isNotEmpty
                ? RefreshIndicator(
                    onRefresh: controller.onRefresh,
                    child: SingleChildScrollView(
                      controller: controller.scrollController,
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              controller.goToCreatePost();
                            },
                            child: const CustomNewPost(),
                          ),
                          Obx(
                            () {
                              return ListView.builder(
                                shrinkWrap: true,
                                // addAutomaticKeepAlives: true,
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: controller.hasMore.value
                                    ? controller.itemData.length + 1
                                    : controller.itemData.length,
                                itemBuilder: (context, index) {
                                  if (index < controller.itemData.length) {
                                    return Card(
                                      child: CustomPostContainer(
                                        itemsModel: ItemsModel.fromJson(
                                            controller.itemData[index]),
                                      ),
                                    );
                                  } else {
                                    return const Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: AppColor.primaryColor,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: controller.onRefresh,
                    child: const CustomNoData(),
                  ),
          ),
        );
      },
    );
  }
}
