import 'package:flutter/material.dart';
import 'package:gestures/models/gesture.dart';
import 'package:gestures/screens/gesture/gesture_screen.dart';
import 'package:gestures/screens/package/components/gesture_list_tile.dart';
import 'package:gestures/services/search_service.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class GestureList extends StatefulWidget {
  final List<Gesture> gestures;
  final bool showPackageTitle;

  const GestureList({
    super.key,
    required this.gestures,
    required this.showPackageTitle,
  });

  @override
  State<GestureList> createState() => GestureListState();
}

class GestureListState extends State<GestureList> {
  late List<Gesture> gestures;

  @override
  void initState() {
    gestures = widget.gestures;
    super.initState();
  }

  void _navigateToGesture(BuildContext context, Gesture gesture) {
    context.go(
      GestureScreen.path(
        packageId: gesture.packageId,
        gestureId: gesture.title,
      ),
    );
  }

  void search(String search) {
    final searchService = GetIt.I<SearchService>();
    final results = searchService.search(widget.gestures, search);
    setState(() {
      gestures = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (final gesture in gestures)
          GestureListTile(
            gesture: gesture,
            onTap: (gesture) => _navigateToGesture(context, gesture),
            showPackageTitle: widget.showPackageTitle,
          ),
      ],
    );
  }
}
