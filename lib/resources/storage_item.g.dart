// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StorageItem _$StorageItemFromJson(Map<String, dynamic> json) {
  return StorageItem(
    json['id'] as String,
    json['name'] as String,
  )
    ..type = json['type'] as String
    ..description = json['description'] as String?;
}

Map<String, dynamic> _$StorageItemToJson(StorageItem instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
    };
