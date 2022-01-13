// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gesture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Gesture _$GestureFromJson(Map<String, dynamic> json) => Gesture(
      title: json['title'] as String,
      filename: json['filename'] as String,
      sharingLink: json['sharingLink'] as String?,
      synonyms: (json['synonyms'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$GestureToJson(Gesture instance) => <String, dynamic>{
      'title': instance.title,
      'filename': instance.filename,
      'sharingLink': instance.sharingLink,
      'synonyms': instance.synonyms,
    };
