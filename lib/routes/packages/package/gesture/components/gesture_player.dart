import 'package:chewie/chewie.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gestures/models/distinct_gesture.dart';
import 'package:micha_core/micha_core.dart';
import 'package:video_player/video_player.dart';

class GesturePlayer extends StatefulWidget {
  final DistinctGesture gesture;

  const GesturePlayer({super.key, required this.gesture});

  @override
  State<GesturePlayer> createState() => _GesturePlayerState();
}

class _GesturePlayerState extends State<GesturePlayer> {
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    final storage = FirebaseStorage.instance;
    final storageRef = storage.ref(widget.gesture.fullPath);
    final url = await storageRef.getDownloadURL();
    if (!context.mounted) return;
    setState(() {
      final controller = VideoPlayerController.networkUrl(Uri.parse(url));
      _chewieController = ChewieController(
        videoPlayerController: controller,
        autoPlay: true,
        showControlsOnInitialize: false,
        errorBuilder: _errorBuilder,
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

  Widget _errorBuilder(BuildContext context, String errorMessage) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline, size: 48),
          ThemedText.headlineSmall(
            'Ein Fehler ist aufgetreten:',
            textAlign: TextAlign.center,
          ),
          Text(
            errorMessage,
            textAlign: TextAlign.center,
          ),
        ].separated(Gap()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
