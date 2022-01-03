import 'package:json_annotation/json_annotation.dart';

part 'gesture.g.dart';

@JsonSerializable()
class Gesture {
  String title;
  String filename;

  Gesture({
    required this.title,
    required this.filename,
  });

  factory Gesture.fromJson(Map<String, dynamic> json) =>
      _$GestureFromJson(json);

  Map<String, dynamic> toJson() => _$GestureToJson(this);
}
