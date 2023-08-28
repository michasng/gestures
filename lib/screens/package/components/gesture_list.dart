import 'package:flutter/material.dart';
import 'package:gestures/models/gesture.dart';
import 'package:gestures/models/package.dart';
import 'package:gestures/screens/package/components/gesture_list_tile.dart';
import 'package:gestures/services/search_service.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class GestureList extends StatefulWidget {
  final Package package;

  const GestureList({super.key, required this.package});

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
    context.go('/packages/${widget.package.title}/gestures/${gesture.title}');
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
