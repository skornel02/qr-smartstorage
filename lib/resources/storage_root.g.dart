// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_root.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StorageRoot _$StorageRootFromJson(Map<String, dynamic> json) {
  return StorageRoot()
    ..description = json['description'] as String?
    ..id = json['id'] as String
    ..name = json['name'] as String
    ..type = json['type'] as String
    ..children = (json['children'] as List<dynamic>)
        .map((e) => Storage.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$StorageRootToJson(StorageRoot instance) =>
    <String, dynamic>{
      'description': instance.description,
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'children': instance.children,
    };
