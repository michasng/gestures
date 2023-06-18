import 'package:flutter/material.dart';
import 'package:gestures/models/gesture.dart';
import 'package:gestures/screens/gesture/components/carousel_controls.dart';
import 'package:gestures/screens/gesture/components/gesture_view.dart';

class GesturesCarousel extends StatefulWidget {
  final List<Gesture> gestures;
  final int initialIndex;
  final void Function(int newIndex)? onRotate;

  const GesturesCarousel({
    super.key,
    required this.gestures,
    required this.initialIndex,
    this.onRotate,
  });

  @override
  State<GesturesCarousel> createState() => _GesturesCarouselState();
}

class _GesturesCarouselState extends State<GesturesCarousel> {
  static const _transitionDuration = Duration(milliseconds: 500);
  static const _transitionCurve = Curves.easeInOut;

  late final PageController _controller;
  late int _currentIndex;
  Future<void> _pageTransition = Future.value();

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _controller = PageController(initialPage: widget.initialIndex);
  }

  void _previous() {
    _animateToPage(_currentIndex - 1);
  }

  void _next() {
    _animateToPage(_currentIndex + 1);
  }

  void _animateToPage(int newIndex) {
    setState(() {
      _currentIndex = newIndex % widget.gestures.length;
      _pageTransition = _controller.animateToPage(
        _currentIndex,
        duration: _transitionDuration,
        curve: _transitionCurve,
      );
    });
    widget.onRotate?.call(_currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _controller,
      itemCount: widget.gestures.length,
      itemBuilder: (context, index) {
        return FutureBuilder(
          future: _pageTransition, // prevent playback during page transition
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done)
              return Container(); // TODO: Show placeholder for moving pages

            return GestureView(
              gesture: widget.gestures[index],
              controlsChild: CarouselControls(
                gesture: widget.gestures[index],
                onPrevious: _previous,
                onNext: _next,
              ),
            );
          },
        );
      },
    );
  }
}
