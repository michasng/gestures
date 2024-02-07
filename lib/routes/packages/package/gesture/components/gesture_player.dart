import 'package:chewie/chewie.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gestures/models/distinct_gesture.dart';
import 'package:micha_core/micha_core.dart';
import 'package:universal_html/html.dart' as html;
import 'package:video_player/video_player.dart';

class GesturePlayer extends StatefulWidget {
  final DistinctGesture gesture;

  const GesturePlayer({super.key, required this.gesture});

  @override
  State<GesturePlayer> createState() => _GesturePlayerState();
}

class _GesturePlayerState extends State<GesturePlayer> {
  static final _logger = createLogger(GesturePlayer);

  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    if (!(html.window.navigator.onLine ?? false)) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _showSnackbar('Kein Internet verfügbar.'),
      );
    }

    String url;
    try {
      final storage = FirebaseStorage.instance;
      final storageRef = storage.ref(widget.gesture.fullPath);
      url = await storageRef.getDownloadURL();
    } catch (error) {
      _showSnackbar(error.toString());
      return;
    }

    if (!mounted) return;
    final videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(url));
    setState(() {
      _videoPlayerController = videoPlayerController;
      _chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        showControlsOnInitialize: false,
        errorBuilder: _errorBuilder,
      );
    });

    try {
      await videoPlayerController.initialize();
      await videoPlayerController.play();
    } catch (e) {
      _logger.severe('Video failed to initialize or play.', e);
    }
  }

  void _showSnackbar(String message) {
    if (!mounted) return;
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  void deactivate() {
    // prevent building inside of a build-cycle
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _videoPlayerController?.pause();
    });
    super.deactivate();
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoPlayerController?.dispose();
    super.dispose();
  }

  Widget _errorBuilder(BuildContext context, String errorMessage) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, size: 48),
          const ThemedText.headlineSmall(
            'Ein Fehler ist aufgetreten:',
            textAlign: TextAlign.center,
          ),
          Text(
            errorMessage,
            textAlign: TextAlign.center,
          ),
        ].separated(const Gap()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_chewieController == null) return const Spinner(size: 128);

    return Chewie(
      controller: _chewieController!,
    );
  }
}
