// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_object_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StorageObjectItem _$StorageObjectItemFromJson(Map<String, dynamic> json) =>
    StorageObjectItem(
      name: json['name'] as String,
      contentType: json['contentType'] as String,
      size: json['size'] as String,
      metadata: json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );
