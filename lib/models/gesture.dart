class Gesture implements Comparable<Gesture> {
  final String packageId;
  final String title;
  final String fullPath;
  final List<String> synonyms;

  const Gesture({
    required this.packageId,
    required this.title,
    required this.fullPath,
    this.synonyms = const [],
  });

  List<String> get searchTerms => [title, ...synonyms];

  @override
  int compareTo(Gesture other) {
    return title.compareTo(other.title);
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'fullPath': fullPath,
      'synonyms': synonyms,
    };
  }

  factory Gesture.fromJson(
    Map<String, dynamic> json, {
    required String packageId,
  }) {
    return Gesture(
      packageId: packageId,
      title: json['title'],
      fullPath: json['fullPath'],
      synonyms: (json['synonyms'] as List)
          .map((synonymJson) => synonymJson as String)
          .toList(),
    );
  }
}
