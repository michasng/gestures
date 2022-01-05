import 'package:flutter/material.dart';
import 'package:gestures/models/gesture.dart';
import 'package:gestures/screens/gesture/components/gesture_view.dart';

class GestureScreen extends StatefulWidget {
  final List<Gesture> gestures;
  final int initialIndex;

  const GestureScreen({
    Key? key,
    required this.gestures,
    required this.initialIndex,
  }) : super(key: key);

  @override
  State<GestureScreen> createState() => _GestureScreenState();
}

class _GestureScreenState extends State<GestureScreen> {
  late final PageController _controller;
  final _transitionDuration = const Duration(milliseconds: 500);
  final _transitionCurve = Curves.easeInOut;

  @override
  void initState() {
    _controller = PageController(initialPage: widget.initialIndex);
    super.initState();
  }

  void _previous() {
    _controller.previousPage(
      duration: _transitionDuration,
      curve: _transitionCurve,
    );
  }

  void _next() {
    _controller.nextPage(
      duration: _transitionDuration,
      curve: _transitionCurve,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gebärde')),
      body: PageView.builder(
        controller: _controller,
        itemCount: widget.gestures.length,
        itemBuilder: (context, index) {
          return GestureView(
            gesture: widget.gestures[index],
            onPrevious: (index == 0) ? null : _previous,
            onNext: (index == widget.gestures.length - 1) ? null : _next,
          );
        },
      ),
    );
  }
}
