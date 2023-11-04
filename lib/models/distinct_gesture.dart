import 'package:gestures/models/gesture.dart';
import 'package:gestures/models/package.dart';

class DistinctGesture implements Comparable<DistinctGesture> {
  final Package package;
  final Gesture _gesture;

  const DistinctGesture({
    required this.package,
    required Gesture gesture,
  }) : _gesture = gesture;

  String get id => _gesture.id;
  String get title => _gesture.title;
  List<String>? get synonyms => _gesture.synonyms;
  List<String> get searchTerms => _gesture.searchTerms;

  String get fullPath => 'Gebärden/${package.id}/${_gesture.id}.mp4';

  @override
  int compareTo(DistinctGesture other) {
    return _gesture.compareTo(other._gesture);
  }
}
