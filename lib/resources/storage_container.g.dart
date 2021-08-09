// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_container.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StorageContainer _$StorageContainerFromJson(Map<String, dynamic> json) {
  return StorageContainer(
    json['id'] as String,
    json['name'] as String,
  )
    ..type = json['type'] as String
    ..description = json['description'] as String?
    ..children = (json['children'] as List<dynamic>)
        .map((e) => Storage.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$StorageContainerToJson(StorageContainer instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'children': instance.children,
    };
