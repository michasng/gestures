import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:gestures/models/gesture.dart';
import 'package:video_player/video_player.dart';

class GesturePlayer extends StatefulWidget {
  final Gesture gesture;

  const GesturePlayer({super.key, required this.gesture});

  @override
  State<GesturePlayer> createState() => _GesturePlayerState();
}

class _GesturePlayerState extends State<GesturePlayer> {
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();

    print('Now playing: ${widget.gesture.directLink}');
    setState(() {
      final controller =
          VideoPlayerController.network(widget.gesture.directLink);
      _chewieController = ChewieController(
        videoPlayerController: controller,
        // aspectRatio: 1 / 1, // stretch and squash the video to force-fit the frame
        autoPlay: true,
        showOptions: false,
      );
    });
  }

  @override
  void deactivate() {
    // prevent building inside of a build-cycle
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _chewieController?.pause();
    });
    super.deactivate();
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /*
    return AspectRatio(
      aspectRatio: 1 / 1, // aspect ratio of the video frame
      child: Chewie(
        controller: _chewieController,
      ),
    );
    */
    if (_chewieController == null)
      return const Center(
        child: SizedBox(
          width: 128,
          height: 128,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    else
      return Chewie(
        controller: _chewieController!,
      );
  }
}
