// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_objects_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StorageObjectsResponse _$StorageObjectsResponseFromJson(
        Map<String, dynamic> json) =>
    StorageObjectsResponse(
      items: (json['items'] as List<dynamic>)
          .map((e) => StorageObjectItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
