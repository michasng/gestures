class Gesture implements Comparable<Gesture> {
  static const String rootDirectory = 'Gebärden';

  final String id;
  final List<String>? synonyms;

  const Gesture({
    required this.id,
    this.synonyms,
  });

  String get packageId => id.split('/').first;
  String get title => id.split('/').last;
  String get fullPath => '$rootDirectory/$id.mp4';

  List<String> get searchTerms => [title, if (synonyms != null) ...synonyms!];

  @override
  int compareTo(Gesture other) {
    return title.compareTo(other.title);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      if (synonyms != null) 'synonyms': synonyms,
    };
  }

  factory Gesture.fromJson(Map<String, dynamic> json) {
    return Gesture(
      id: json['id'],
      synonyms: (json['synonyms'] as List?)
          ?.map((synonymJson) => synonymJson as String)
          .toList(),
    );
  }
}
