import 'package:gestures/services/responses/storage_objects_response/storage_object_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'storage_objects_response.g.dart';

@JsonSerializable(createToJson: false)
class StorageObjectsResponse {
  final List<StorageObjectItem> items;

  const StorageObjectsResponse({
    required this.items,
  });

  factory StorageObjectsResponse.fromJson(Map<String, dynamic> json) =>
      _$StorageObjectsResponseFromJson(json);
}
