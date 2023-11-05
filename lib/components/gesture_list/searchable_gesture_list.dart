import 'package:flutter/material.dart';
import 'package:gestures/components/gesture_list/gesture_list.dart';
import 'package:gestures/models/distinct_gesture.dart';
import 'package:gestures/services/search_service.dart';
import 'package:get_it/get_it.dart';

class SearchableGestureList extends StatefulWidget {
  final List<DistinctGesture> gestures;
  final String? initialSearchKey;
  final bool showPackageTitles;
  final void Function(DistinctGesture gesture, String? searchKey) onTapGesture;

  const SearchableGestureList({
    super.key,
    required this.gestures,
    required this.initialSearchKey,
    required this.showPackageTitles,
    required this.onTapGesture,
  });

  @override
  State<SearchableGestureList> createState() => SearchableGestureListState();
}

class SearchableGestureListState extends State<SearchableGestureList> {
  late List<DistinctGesture> _gestures;
  String? _searchKey;

  @override
  void initState() {
    super.initState();
    _search(widget.initialSearchKey);
  }

  void _search(String? searchKey) {
    if (searchKey == null || searchKey.isEmpty) {
      setState(() {
        _searchKey = null;
        _gestures = widget.gestures;
      });
      return;
    }

    final searchService = GetIt.I<SearchService>();
    final gestures = searchService.search(widget.gestures, searchKey);
    setState(() {
      _searchKey = searchKey;
      _gestures = gestures;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            autofocus: false,
            decoration: const InputDecoration(
              labelText: 'Suche',
            ),
            onChanged: _search,
          ),
        ),
        Expanded(
          child: GestureList(
            gestures: _gestures,
            showPackageTitles: widget.showPackageTitles,
            onTapGesture: (gesture) => widget.onTapGesture(gesture, _searchKey),
          ),
        ),
      ],
    );
  }
}
