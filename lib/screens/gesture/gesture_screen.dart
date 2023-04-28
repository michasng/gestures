import 'package:flutter/material.dart';
import 'package:gestures/models/gesture.dart';
import 'package:gestures/screens/gesture/components/gesture_view.dart';

class GestureScreen extends StatefulWidget {
  final List<Gesture> gestures;
  final int initialIndex;

  const GestureScreen({
    super.key,
    required this.gestures,
    required this.initialIndex,
  });

  @override
  State<GestureScreen> createState() => _GestureScreenState();
}

class _GestureScreenState extends State<GestureScreen> {
  late final PageController _controller;
  final _transitionDuration = const Duration(milliseconds: 500);
  final _transitionCurve = Curves.easeInOut;
  Future<void> _pageTransition = Future.value();

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: widget.initialIndex);
  }

  void _animateToPage(int index) {
    final loopingIndex = index % widget.gestures.length;
    setState(() {
      _pageTransition = _controller.animateToPage(
        loopingIndex,
        duration: _transitionDuration,
        curve: _transitionCurve,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gebärde')),
      body: PageView.builder(
        controller: _controller,
        itemCount: widget.gestures.length,
        itemBuilder: (context, index) {
          return FutureBuilder(
            future: _pageTransition,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done)
                return Container(); // prevent playback during page transition

              return GestureView(
                gesture: widget.gestures[index],
                onPrevious: () => _animateToPage(index - 1),
                onNext: () => _animateToPage(index + 1),
              );
            },
          );
        },
      ),
    );
  }
}
