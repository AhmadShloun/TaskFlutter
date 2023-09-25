import 'package:flutter/material.dart';

class CustomChoseFileCreate extends StatelessWidget {
  final void Function() onPressedCamera;
  final void Function() onPressedImage;
  final void Function() onPressedVideo;
  const CustomChoseFileCreate({super.key, required this.onPressedCamera, required this.onPressedImage, required this.onPressedVideo});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Expanded(
          child: IconButton(
            onPressed: onPressedCamera,
            icon: const Icon(
              Icons.photo_camera_outlined,
              color: Colors.pink,
            ),
          ),
        ),
        Container(
          width: 0.5,
          height: 30,
          color: Colors.grey,
        ),

        Expanded(
          child: IconButton(
            onPressed: onPressedImage,
            icon: const Icon(
              Icons.photo_library,
              color: Colors.green,
            ),
          ),
        ),
        Container(
          width: 0.5,
          height: 30,
          color: Colors.grey,
        ),
        Expanded(
          child: IconButton(
            onPressed: onPressedVideo,
            icon: const Icon(
              Icons.video_camera_back_outlined,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
