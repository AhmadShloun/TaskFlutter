import 'package:flutter/material.dart';
import 'package:task_flutter/data/model/homemodel/items_model.dart';
import 'package:task_flutter/view/widget/home/custom_button_post.dart';

class CustomPostStats extends StatelessWidget {
  final ItemsModel items;

  const CustomPostStats({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {},
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                    color: Colors.blue, shape: BoxShape.circle),
                child:
                    const Icon(Icons.thumb_up, size: 12, color: Colors.white),
              ),
              const Icon(Icons.favorite, size: 18, color: Colors.red),
              const SizedBox(width: 8),
              Expanded(
                  child: Text("${items.interactionsCount}",
                      style: TextStyle(color: Colors.grey[600]))),
              Text("comments ${items.commentsCount}",
                  style: TextStyle(color: Colors.grey[600])),
              const SizedBox(width: 8),
              Text("Shares ${items.sharesCount}",
                  style: TextStyle(color: Colors.grey[600])),
              const SizedBox(width: 8),
              Text("tag ${items.tagsCount}",
                  style: TextStyle(color: Colors.grey[600]))
            ],
          ),
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Icon(MdiIcons.thumbUpOutline,
            CustomPostButton(
                icon: Icon(Icons.thumb_up_off_alt_outlined,
                    color: Colors.grey[600], size: 20),
                label: "Like",
                onTap: () => {}),
            CustomPostButton(
                icon: Icon(Icons.insert_comment_sharp,
                    color: Colors.grey[600], size: 20),
                label: "Comment",
                onTap: () => {}),
            CustomPostButton(
                icon: Icon(Icons.share, color: Colors.grey[600], size: 25),
                label: "Share",
                onTap: () => {}),
          ],
        )
      ],
    );
  }
}
