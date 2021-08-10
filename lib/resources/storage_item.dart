import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:qr_smartstorage/resources/storage.dart';

part 'storage_item.g.dart';

@JsonSerializable()
class StorageItem extends Equatable implements Storage {
  final String type;
  final String id;
  final String name;
  final String? description;
  final DateTime creation;

  StorageItem(this.type, this.id, this.name, this.description, this.creation);

  StorageItem.empty(this.id, this.name)
      : this.type = "Item",
        this.description = null,
        this.creation = DateTime.now();

  StorageItem.create(
      {required String id,
      required String name,
      String? description,
      required DateTime creation})
      : this.type = "Item",
        this.id = id,
        this.name = name,
        this.description = description,
        this.creation = creation;

  StorageItem copy({String? withoutId}) {
    return StorageItem.create(
      id: this.id,
      name: this.name,
      description: this.description,
      creation: this.creation,
    );
  }

  factory StorageItem.fromJson(Map<String, dynamic> json) =>
      _$StorageItemFromJson(json);

  Map<String, dynamic> toJson() => _$StorageItemToJson(this);

  @override
  List<Object> get props => [type, id, name, creation, description ?? ""];

  @override
  bool get stringify => true;
}
