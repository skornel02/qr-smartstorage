import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:qr_smartstorage/resources/storage.dart';

part 'storage_item.g.dart';

@JsonSerializable()
class StorageItem extends Equatable implements Storage {
  String type = "Item";
  String id;
  String name;
  String? description;
  DateTime creation;

  StorageItem(this.id, this.name) : creation = DateTime.now();

  factory StorageItem.fromJson(Map<String, dynamic> json) =>
      _$StorageItemFromJson(json);

  Map<String, dynamic> toJson() => _$StorageItemToJson(this);

  @override
  List<Object> get props => [type, id, name, creation];
}
