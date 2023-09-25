import 'package:flutter/material.dart';
import 'package:task_flutter/core/constant/color.dart';

class CustomNewPost extends StatelessWidget {
  const CustomNewPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text('What\'s on your mind?',style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColor.grey),),
              )
            ],
          ),
          const Divider(
            height: 10,
            thickness: 0.5,
          ),
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(
                  Icons.videocam,
                  color: Colors.red,
                ),

                VerticalDivider(
                  width: 8,
                ),
                Icon(
                  Icons.photo_library,
                  color: Colors.green,
                )

              ],
            ),
          )
        ],
      ),
    );
  }
}
