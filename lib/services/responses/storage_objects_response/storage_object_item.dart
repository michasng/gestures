import 'package:gestures/services/responses/storage_objects_response/metadata.dart';
import 'package:json_annotation/json_annotation.dart';

part 'storage_object_item.g.dart';

@JsonSerializable(createToJson: false)
class StorageObjectItem {
  // a path like "Gebärden/Arbeitssicherheit/Arbeiter.mp4"
  final String name;
  final String contentType;
  final String size;
  final Metadata? metadata;

  const StorageObjectItem({
    required this.name,
    required this.contentType,
    required this.size,
    this.metadata,
  });

  factory StorageObjectItem.fromJson(Map<String, dynamic> json) =>
      _$StorageObjectItemFromJson(json);
}
