import 'package:json_annotation/json_annotation.dart';

part 'gesture.g.dart';

@JsonSerializable()
class Gesture implements Comparable<Gesture> {
  final String title;
  final String filename;
  final String? sharingLink;
  final List<String> synonyms;

  const Gesture({
    required this.title,
    required this.filename,
    this.sharingLink,
    this.synonyms = const [],
  });

  String get assetFilePath => 'assets/gestures/$filename';

  List<String> get searchTerms => [title, ...synonyms];

  factory Gesture.fromJson(Map<String, dynamic> json) =>
      _$GestureFromJson(json);

  Map<String, dynamic> toJson() => _$GestureToJson(this);

  @override
  int compareTo(Gesture other) {
    return title.compareTo(other.title);
  }
}
