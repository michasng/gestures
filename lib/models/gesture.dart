import 'package:json_annotation/json_annotation.dart';

part 'gesture.g.dart';

@JsonSerializable()
class Gesture implements Comparable<Gesture> {
  final String title;
  final String filename;
  final List<String> synonyms;

  const Gesture({
    required this.title,
    required this.filename,
    this.synonyms = const [],
  });

  List<String> get searchTerms => [title, ...synonyms];

  factory Gesture.fromJson(Map<String, dynamic> json) =>
      _$GestureFromJson(json);

  Map<String, dynamic> toJson() => _$GestureToJson(this);

  @override
  int compareTo(Gesture other) {
    return title.compareTo(other.title);
  }
}
