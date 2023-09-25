import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_flutter/controller/createpost_controller.dart';
import 'package:task_flutter/core/class/handlingdataview.dart';
import 'package:task_flutter/core/constant/color.dart';
import 'package:task_flutter/view/widget/createpost/custom_chose_file_create.dart';
import 'package:task_flutter/view/widget/createpost/custom_header_create.dart';
import 'package:video_player/video_player.dart';

class CreatePostScreen extends GetView<CreatePostControllerImp> {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CreatePostControllerImp());
    return WillPopScope(
      onWillPop: () async {
        controller.goToBack();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primaryColor,
          title: const Center(child: Text("New Post")),
          elevation: 0,
          actions: [
            GetBuilder<CreatePostControllerImp>(builder: (controller) {
              return HandlingDataRequest(
                statusRequest: controller.statusRequest,
                widget: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.transparent, elevation: 0),
                  onPressed: () {
                    controller.create();
                  },
                  child: const Text('Post'),
                ),
              );
            })
          ],
          leading: IconButton(
              onPressed: () {
                controller.goToBack();
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: GetBuilder<CreatePostControllerImp>(
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 20),
                  const CustomHeaderCreate(),
                  const SizedBox(height: 20),
                  CustomChoseFileCreate(
                    onPressedCamera: () {
                      controller.uploadMedia("camera");
                    },
                    onPressedImage: () {
                      controller.uploadMedia("image");
                    },
                    onPressedVideo: () {
                      controller.uploadMedia("video");
                    },
                  ),
                  const Divider(
                    color: Colors.grey,
                    height: 2,
                  ),
                  TextFormField(
                    controller: controller.content,
                    maxLines: 10,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'What\'s on your Mind?',
                      hintStyle: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: Container(
                      height: Get.height / 3,
                      width: double.infinity,
                      color: controller.filePath == null
                          ? null
                          : Colors.grey.shade200,
                      child: controller.fileType?[0] == "image"
                          ? Center(
                              child: Image.file(
                                  File(controller.filePath.toString()),
                                  fit: BoxFit.contain),
                            )
                          : controller.fileType?[0] == 'video'
                              ? Column(
                                  children: [
                                    Expanded(
                                      child: Stack(
                                        alignment: Alignment.bottomLeft,
                                        // fit: StackFit.loose,

                                        children: [
                                          VideoPlayer(
                                              controller.videoController),
                                          ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.redAccent),
                                            ),
                                            onPressed: () {
                                              if (controller.isVideoPlaying) {
                                                controller.videoController
                                                    .pause();
                                              } else {
                                                controller.videoController
                                                    .play();
                                              }
                                              controller.showStatusVideo();
                                            },
                                            child: controller.isVideoPlaying
                                                ? const Icon(Icons.pause)
                                                : const Icon(Icons.play_arrow),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : null,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
