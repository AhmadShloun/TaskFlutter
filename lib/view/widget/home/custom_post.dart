import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_flutter/controller/home_controller.dart';
import 'package:task_flutter/core/constant/imageasset.dart';
import 'package:task_flutter/data/model/homemodel/items_model.dart';
import 'package:task_flutter/data/model/homemodel/user_model.dart';
import 'package:task_flutter/view/widget/home/custom_post_header.dart';
import 'package:task_flutter/view/widget/home/custom_stats_post.dart';
import 'package:task_flutter/view/widget/home/video_items.dart';
import 'package:video_player/video_player.dart';

class CustomPostContainer extends GetView<HomeControllerImp> {
  final ItemsModel itemsModel;

  const CustomPostContainer({super.key, required this.itemsModel});

  @override
  Widget build(BuildContext context) {
    List<String> time = [];
    if (itemsModel.hasMedia == true) {
      for (var mediaItem in itemsModel.media!) {
        if (mediaItem.collectionName == 'media') {
          time.add(mediaItem.updatedAt.toString());
        }
      }
    }
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomPostHeader(model:itemsModel.model! ,time: time,),
                const SizedBox(height: 25),
                Text(
                  itemsModel.content ?? " ",
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          itemsModel.media!.isNotEmpty
              ? GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: itemsModel.media!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: itemsModel.media!.length >= 3
                        ? 2
                        : itemsModel.media!.length,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                  itemBuilder: (context, index) {
                    return itemsModel.hasMedia == true &&
                            itemsModel.media![index].mediaType == "Image" &&
                            (itemsModel.media![index].mimeType!
                                    .endsWith("jpg") ||
                                itemsModel.media![index].mimeType!
                                    .endsWith("jpeg") ||
                                itemsModel.media![index].mimeType!
                                    .endsWith("png"))
                        ? CachedNetworkImage(
                            imageUrl: "${itemsModel.media![index].srcUrl}",
                            errorWidget: (context, url, error) {
                              return Image.asset(
                                AppImageAsset.vpn,
                                // Provide the path to your alternative image asset
                                fit: BoxFit.cover, // Adjust the fit as needed
                              );
                            },
                            fit: itemsModel.media!.length >= 2
                                ? BoxFit.cover
                                : BoxFit.contain,
                          )
                        : itemsModel.hasMedia == true &&
                                itemsModel.media![index].mediaType!
                                    .endsWith("ideo") &&
                                itemsModel.media![index].mimeType!
                                    .contains("mp4")
                            ? VideoItems(
                                videoPlayerController:
                                    VideoPlayerController.networkUrl(
                                  Uri.parse(itemsModel.media![index].srcUrl
                                      .toString()),
                                ),
                                looping: false,
                                autoplay: false,
                              )
                            : null;
                  },
                )
              : const SizedBox(height: 25),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: CustomPostStats(items: itemsModel,),
          ),
        ],
      ),
    );
  }
}






