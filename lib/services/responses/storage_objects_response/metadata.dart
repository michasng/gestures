import 'package:json_annotation/json_annotation.dart';

part 'metadata.g.dart';

@JsonSerializable(createToJson: false)
class Metadata {
  final String? synonyms;

  const Metadata({
    this.synonyms,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) =>
      _$MetadataFromJson(json);
}
