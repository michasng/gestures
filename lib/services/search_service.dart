import 'package:gestures/models/gesture.dart';

class SearchService {
  String toSearchString(String text) {
    return text.replaceAll(' ', '').toLowerCase();
  }

  Iterable<Gesture> _searchBy(
    List<Gesture> gestures,
    bool Function(String term) isMatch,
  ) {
    return gestures.where(
      (gesture) =>
          gesture.searchTerms
              .indexWhere((term) => isMatch(toSearchString(term))) !=
          -1,
    );
  }

  List<Gesture> search(List<Gesture> gestures, String search) {
    final searchString = toSearchString(search);

    final exactMatches = _searchBy(
      gestures,
      (term) => term == searchString,
    );

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
    return <Gesture>{...exactMatches, ...prefixMatches, ...containedMatches}
        .toList();
  }
}
