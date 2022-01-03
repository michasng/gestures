// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Package _$PackageFromJson(Map<String, dynamic> json) => Package(
      title: json['title'] as String,
      gestures: (json['gestures'] as List<dynamic>)
          .map((e) => Gesture.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PackageToJson(Package instance) => <String, dynamic>{
      'title': instance.title,
      'gestures': instance.gestures,
    };
