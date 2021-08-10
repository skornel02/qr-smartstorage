// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StorageItem _$StorageItemFromJson(Map<String, dynamic> json) {
  return StorageItem(
    json['type'] as String,
    json['id'] as String,
    json['name'] as String,
    json['description'] as String?,
    DateTime.parse(json['creation'] as String),
  );
}

Map<String, dynamic> _$StorageItemToJson(StorageItem instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'creation': instance.creation.toIso8601String(),
    };
