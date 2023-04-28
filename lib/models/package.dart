import 'package:gestures/models/gesture.dart';

class Package {
  final String title;
  final List<Gesture> gestures;

  const Package({
    required this.title,
    required this.gestures,
  });
}
