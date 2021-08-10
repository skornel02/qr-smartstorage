// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_root.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StorageRoot _$StorageRootFromJson(Map<String, dynamic> json) {
  return StorageRoot(
    json['type'] as String,
    (json['children'] as List<dynamic>)
        .map((e) => Storage.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$StorageRootToJson(StorageRoot instance) =>
    <String, dynamic>{
      'type': instance.type,
      'children': instance.children,
    };
