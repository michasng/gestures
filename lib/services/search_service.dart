import 'package:gestures/models/distinct_gesture.dart';

class SearchService {
  String toSearchString(String text) {
    return text.replaceAll(' ', '').toLowerCase();
  }

  Iterable<DistinctGesture> _searchBy(
    List<DistinctGesture> gestures,
    bool Function(String term) isMatch,
  ) {
    return gestures.where(
      (gesture) =>
          gesture.searchTerms
              .indexWhere((term) => isMatch(toSearchString(term))) !=
          -1,
    );
  }

  List<DistinctGesture> search(List<DistinctGesture> gestures, String search) {
    final searchString = toSearchString(search);

    final exactMatches = _searchBy(
      gestures,
      (term) => term == searchString,
    ).toList();
    exactMatches.sort();

    final prefixMatches = _searchBy(
      gestures,
      (term) => term.startsWith(searchString),
    ).toList();
    prefixMatches.sort();

    final containedMatches = _searchBy(
      gestures,
      (term) => term.contains(searchString),
    ).toList();
    containedMatches.sort();

    // combine and remove duplicate entries with a set literal
    return <DistinctGesture>{
      ...exactMatches,
      ...prefixMatches,
      ...containedMatches,
    }.toList();
  }
}
