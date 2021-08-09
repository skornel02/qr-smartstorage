import 'package:json_annotation/json_annotation.dart';
import 'package:qr_smartstorage/resources/storage.dart';

part 'storage_root.g.dart';

@JsonSerializable()
class StorageRoot implements Storage {
  String? description;
  String id = "0";
  String name = "Root";
  String type = "Root";
  List<Storage> children = [];

  StorageRoot();

  factory StorageRoot.fromJson(Map<String, dynamic> json) =>
      _$StorageRootFromJson(json);

  Map<String, dynamic> toJson() => _$StorageRootToJson(this);
}
