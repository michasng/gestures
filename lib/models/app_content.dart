import 'package:gestures/models/package.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_content.g.dart';

@JsonSerializable()
class AppContent {
  final List<Package> packages;

  const AppContent({
    required this.packages,
  });

  factory AppContent.fromJson(Map<String, dynamic> json) =>
      _$AppContentFromJson(json);

  Map<String, dynamic> toJson() => _$AppContentToJson(this);
}
