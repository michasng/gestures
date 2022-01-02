import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class GesturePlayer extends StatefulWidget {
  const GesturePlayer({Key? key}) : super(key: key);

  @override
  _GesturePlayerState createState() => _GesturePlayerState();
}

class _GesturePlayerState extends State<GesturePlayer> {
  late final ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    final controller = VideoPlayerController.asset('assets/video.mov')
      ..initialize();

    _chewieController = ChewieController(
      videoPlayerController: controller,
      aspectRatio: 1 / 1, // stretch and squash the video to force-fit the frame
      autoPlay: true,
      showOptions: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        AspectRatio(
          aspectRatio: 1 / 1, // aspect ratio of the video frame
          child: Chewie(
            controller: _chewieController,
          ),
        ),
        ListTile(
          title: Text(
            'Lautzeichen A',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
      ],
    );
  }
}
