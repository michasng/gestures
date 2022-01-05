import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:gestures/models/gesture.dart';
import 'package:video_player/video_player.dart';

class GesturePlayer extends StatefulWidget {
  final Gesture gesture;

  const GesturePlayer({Key? key, required this.gesture}) : super(key: key);

  @override
  _GesturePlayerState createState() => _GesturePlayerState();
}

class _GesturePlayerState extends State<GesturePlayer> {
  late final ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    final filepath = 'assets/gestures/${widget.gesture.filename}';
    final _controller = VideoPlayerController.asset(filepath);

    _chewieController = ChewieController(
      videoPlayerController: _controller,
      // aspectRatio: 1 / 1, // stretch and squash the video to force-fit the frame
      autoPlay: true,
      showOptions: false,
    );
  }

  @override
  void deactivate() {
    // prevent building inside of a build-cycle
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _chewieController.pause();
    });
    super.deactivate();
  }

  @override
  void dispose() {
    _chewieController.dispose();
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
    return Chewie(
      controller: _chewieController,
    );
  }
}
