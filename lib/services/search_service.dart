import 'package:gestures/models/gesture.dart';

class SearchService {
  String toSearchString(String text) {
    return text.replaceAll(' ', '').toLowerCase();
  }

  List<Gesture> search(List<Gesture> gestures, String search) {
    final searchString = toSearchString(search);

    final exactMatches = gestures
        .where((gesture) =>
            gesture.searchTerms
                .indexWhere((term) => toSearchString(term) == searchString) !=
            -1)
        .toList();

    final partialMatches = gestures
        .where((gesture) =>
            gesture.searchTerms.indexWhere(
                (term) => toSearchString(term).startsWith(searchString)) !=
            -1)
        .toList();
    partialMatches.sort();

    // combine and remove duplicate entries
    return (exactMatches + partialMatches).toSet().toList();
  }
}
