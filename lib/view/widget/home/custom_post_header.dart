import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:task_flutter/core/constant/imageasset.dart';
import 'package:task_flutter/data/model/homemodel/user_model.dart';

class CustomPostHeader extends StatelessWidget {
  final UserModel model;
  final List<String> time;

  const CustomPostHeader({super.key, required this.model, required this.time});

  @override
  Widget build(BuildContext context) {
    List<String> profileImageUrls = [];
    if (model.hasMediaProfile == true && model.media != null) {
      for (var item in model.media!) {
        if (item.collectionName == 'profile') {
          profileImageUrls.add(item.srcUrl.toString());
        }
      }
    }

    return Row(
      children: [
        profileImageUrls.isNotEmpty
            ? Stack(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: const Color(0xFF1777F2),
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.grey[200],
                      child: ClipOval(
                        child: CachedNetworkImage(
                            imageUrl: profileImageUrls[0],
                            errorWidget: (context, url, error) {
                              return Image.asset(
                                AppImageAsset.vpn,
                                fit: BoxFit.contain,
                              );
                            },
                            width: 40,
                            height: 40,
                            fit: BoxFit.fill),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 13,
                      width: 13,
                      decoration: BoxDecoration(
                          color: const Color(0xFF4BCB1F),
                          shape: BoxShape.circle,
                          border: Border.all(width: 2, color: Colors.white)),
                    ),
                  )
                ],
              )
            : Stack(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: const Color(0xFF1777F2),
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.grey[200],
                      backgroundImage: const AssetImage(AppImageAsset.avatar),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                          color: const Color(0xFF4BCB1F),
                          shape: BoxShape.circle,
                          border: Border.all(width: 2, color: Colors.white)),
                    ),
                  )
                ],
              ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(model.name ?? "Unknown",
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              Row(
                children: [
                  Text(
                    '${time.isNotEmpty ? time[0] : "----"} * ',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  Icon(Icons.public, color: Colors.grey[600], size: 12)
                ],
              ),
            ],
          ),
        ),
        IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {})
      ],
    );
  }
}
