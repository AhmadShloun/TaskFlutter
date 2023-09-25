import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoItems extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;
  final bool autoplay;

  const VideoItems({
    super.key,
    required this.videoPlayerController,
    required this.looping,
    required this.autoplay,
  });

  @override
  _VideoItemsState createState() => _VideoItemsState();
}

class _VideoItemsState extends State<VideoItems> {
  late ChewieController _chewieController;
  bool hasError = false;
  bool isRetrying = false; // Track retrying state

  @override
  void initState() {
    super.initState();
    _initializeChewieController();
  }

  void _initializeChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: widget.videoPlayerController.value.aspectRatio,
      autoInitialize: true,
      autoPlay: widget.autoplay,
      looping: widget.looping,
      errorBuilder: (context, errorMessage) {
        hasError = true;
        isRetrying = false; // Reset retrying state
        return showError();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    _chewieController.dispose();
  }

  Widget showError() {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Video format is not supported",
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
            const SizedBox(height: 10),
            isRetrying
                ? CircularProgressIndicator(color: Colors.cyan) // Show loading indicator while retrying
                : ElevatedButton(
              onPressed: () {
                setState(() {
                  hasError = false;
                  isRetrying = true; // Set retrying state to true
                });
                _initializeChewieController();
              },
              child: const Text("Retry"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (hasError) {
      return showError();
    } else {
      return Chewie(
        controller: _chewieController,
      );
    }
  }
}
