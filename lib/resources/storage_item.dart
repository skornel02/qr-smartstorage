import 'package:json_annotation/json_annotation.dart';
import 'package:qr_smartstorage/resources/storage.dart';

part 'storage_item.g.dart';

@JsonSerializable()
class StorageItem implements Storage {
  String type = "Item";
  String id;
  String name;
  String? description;

  StorageItem(this.id, this.name);

  factory StorageItem.fromJson(Map<String, dynamic> json) =>
      _$StorageItemFromJson(json);

  Map<String, dynamic> toJson() => _$StorageItemToJson(this);
}
