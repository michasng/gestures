class Gesture implements Comparable<Gesture> {
  final String title;
  final String directLink;
  final List<String> synonyms;

  const Gesture({
    required this.title,
    required this.directLink,
    this.synonyms = const [],
  });

  List<String> get searchTerms => [title, ...synonyms];

  @override
  int compareTo(Gesture other) {
    return title.compareTo(other.title);
  }
}
