import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:task_flutter/controller/home_controller.dart';
import 'package:task_flutter/core/class/statusrequest.dart';
import 'package:task_flutter/core/constant/color.dart';
import 'package:task_flutter/core/constant/routes.dart';
import 'package:task_flutter/core/functions/handlingdatacontroller.dart';
import 'dart:convert';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:task_flutter/data/datasource/remote/createpost_data.dart';
import 'package:video_player/video_player.dart';

abstract class CreatePostController extends GetxController {
  uploadMedia(String type);

  pickMedia(String type);

  processPickedMedia(XFile? pickedMedia);

  processVideo();

  processImage();

  create();

  Future<void> fireStore(String filePath, String fileName);

  showSnackBar(String title, String message, Color backgroundColor);

  showStatusVideo();

  goToBack();
}

class CreatePostControllerImp extends CreatePostController {

  StatusRequest statusRequest = StatusRequest.none;
  CreatePostData createPostData = CreatePostData(Get.find());

  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;
  late File image;

  final imagePicker = ImagePicker();
  late FirebaseStorage storage;

  late TextEditingController content;
  late VideoPlayerController videoController;
  String? fileName;
  String? filePath;
  String? downloadUrl;
  String? fullPath;
  List<String>? fileType; //media_type[0] && mime_type[1]
  int? size;
  int? height;
  int? width;
  bool isVideoPlaying = true;
  bool isChoseVideo = false;

  @override
  void onInit() {
    storage = FirebaseStorage.instance;
    content = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  @override
  uploadMedia(type) async {
    final pickedMedia = await pickMedia(type);

    if (pickedMedia != null) {
      processPickedMedia(pickedMedia);
    } else {
      showSnackBar("Error", "No Media Selected", AppColor.red);
    }
  }

  @override
  Future<dynamic> pickMedia(type) async {
    switch (type) {
      case 'camera':
        return await imagePicker.pickImage(source: ImageSource.camera);
      case 'image':
        return await imagePicker.pickImage(source: ImageSource.gallery);
      case 'video':
        return await imagePicker.pickVideo(source: ImageSource.gallery);
      default:
        return null;
    }
  }

  @override
  void processPickedMedia(pickedMedia) async {
    if (pickedMedia == null) return;

    fileName = pickedMedia.path.split('/').last;
    filePath = pickedMedia.path;
    image = File(pickedMedia.path);
    selectedImagePath.value = image.toString();
    selectedImageSize.value = (image).lengthSync().toString();
    String? mimeStr = lookupMimeType(fileName!);
    fileType = mimeStr!.split('/');
    size = int.parse(selectedImageSize.value);
    if (pickedMedia.path.toLowerCase().endsWith('.mp4')) {
      await processVideo();
    } else if (pickedMedia.path.toLowerCase().endsWith('.jpg') ||
        pickedMedia.path.toLowerCase().endsWith('.jpeg') ||
        pickedMedia.path.toLowerCase().endsWith('.png')) {
      await processImage();
    }
  }

  @override
  Future<void> processVideo() async {
    isChoseVideo = true;
    videoController = VideoPlayerController.file(File(filePath!));
    await videoController.initialize();
    width = videoController.value.size.width.toInt();
    height = videoController.value.size.height.toInt();
    videoController.play();
    isVideoPlaying = true;
    update();
  }

  @override
  Future<void> processImage() async {
    final decodedImage = await decodeImageFromList(await image.readAsBytes());
    height = decodedImage.height;
    width = decodedImage.width;

    if (isChoseVideo) {
      videoController.pause();
      isVideoPlaying = false;
      videoController.dispose();
      isChoseVideo = false;
    }

    update();
  }

  @override
  create() async {
    Map<String, dynamic> data = {};

    if (filePath != null) {
      await fireStore(filePath!, fileName!);
      Map<String, dynamic> mediaData = {
        "src_url": downloadUrl,
        "src_thum": "",
        "src_icon": "",
        "media_type": fileType![0],
        "mime_type": fileType![1],
        "fullPath": fullPath,
        "size": size
      };

      if (fileType?[0] != null) {
        mediaData["width"] = width;
        mediaData["height"] = height;
      }
      data['media'] = [mediaData];
    }

    if (content.text.isNotEmpty) {
      data['content'] = content.text;
    }

    if (data.isNotEmpty) {
      statusRequest = StatusRequest.loading;
      update();

      String body = json.encode(data);

      var response = await createPostData.postData(body: body);
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == 201 || response['status'] == 200) {
          HomeControllerImp homeController = Get.find<HomeControllerImp>();
          homeController.itemData.insert(0, response['data']);
          await homeController.reloadData();
          Get.offAllNamed(AppRoute.homepage);
          showSnackBar("Success", "The post has been published successfully",
              AppColor.green);
        } else {
          Get.defaultDialog(title: "Warning", middleText: response['status']);
          statusRequest = StatusRequest.failure;
        }
      } else {
        showSnackBar(
            "Error", "An error occurred. Try again later", AppColor.red);
      }
    } else {
      Get.defaultDialog(title: "No Data ");
    }

    update();
  }

  @override
  Future<void> fireStore(filePath, fileName) async {
    File file = File(filePath);
    try {
      statusRequest = StatusRequest.loading;
      update();

      var fb = await storage.ref('file/$fileName').putFile(file);
      downloadUrl = await fb.ref.getDownloadURL();
      fullPath = fb.ref.fullPath;
    } on firebase_core.FirebaseException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  showSnackBar(title, message, backgroundColor) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: backgroundColor,
      colorText: Colors.white,
    );
  }

  @override
  showStatusVideo() {
    isVideoPlaying = !isVideoPlaying;
    update();
  }

  @override
  goToBack() {
    if (isChoseVideo) {
      isVideoPlaying = false;
      isChoseVideo = false;
      videoController.pause();
      videoController.dispose();
    }
    onDelete();
    Get.back();
  }
}
