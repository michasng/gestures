import 'package:firebase_storage/firebase_storage.dart';

class Gesture implements Comparable<Gesture> {
  final String title;
  final Reference storageReference;
  final List<String> synonyms;

  const Gesture({
    required this.title,
    required this.storageReference,
    this.synonyms = const [],
  });

  List<String> get searchTerms => [title, ...synonyms];

  @override
  int compareTo(Gesture other) {
    return title.compareTo(other.title);
  }
}
