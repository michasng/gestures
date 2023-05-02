import 'package:flutter/material.dart';
import 'package:gestures/models/gesture.dart';
import 'package:gestures/screens/gesture/components/gestures_carousel.dart';

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
  late Gesture currentGesture;

  @override
  void initState() {
    super.initState();
    currentGesture = widget.gestures[widget.initialIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: FittedBox(child: Text(currentGesture.title))),
      body: GesturesCarousel(
        gestures: widget.gestures,
        initialIndex: widget.initialIndex,
        onRotate: (newIndex) => setState(() {
          currentGesture = widget.gestures[newIndex];
        }),
      ),
    );
  }
}
