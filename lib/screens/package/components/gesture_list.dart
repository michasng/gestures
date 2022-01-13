import 'package:flutter/material.dart';
import 'package:gestures/models/gesture.dart';
import 'package:gestures/models/package.dart';
import 'package:gestures/screens/gesture/gesture_screen.dart';
import 'package:gestures/screens/package/components/gesture_list_tile.dart';
import 'package:gestures/services/search_service.dart';
import 'package:get_it/get_it.dart';

class GestureList extends StatefulWidget {
  final Package package;

  const GestureList({Key? key, required this.package}) : super(key: key);

  @override
  State<GestureList> createState() => GestureListState();
}

class GestureListState extends State<GestureList> {
  late List<Gesture> gestures;

  @override
  void initState() {
    gestures = widget.package.gestures;
    super.initState();
  }

  void _navigateToGesture(BuildContext context, Gesture gesture) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => GestureScreen(
          gestures: gestures,
          initialIndex: gestures.indexOf(gesture),
        ),
      ),
    );
  }

  void search(String search) {
    final searchService = GetIt.I<SearchService>();
    final results = searchService.search(widget.package.gestures, search);
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
          ),
      ],
    );
  }
}
