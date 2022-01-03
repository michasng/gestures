// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppContent _$AppContentFromJson(Map<String, dynamic> json) => AppContent(
      packages: (json['packages'] as List<dynamic>)
          .map((e) => Package.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AppContentToJson(AppContent instance) =>
    <String, dynamic>{
      'packages': instance.packages,
    };
