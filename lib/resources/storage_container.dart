import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:qr_smartstorage/resources/storage.dart';

part 'storage_container.g.dart';

@JsonSerializable()
class StorageContainer extends Equatable implements Storage {
  String type = "Container";
  String id;
  String name;
  String? description;

  List<Storage> children = [];

  StorageContainer(this.id, this.name);

  factory StorageContainer.fromJson(Map<String, dynamic> json) =>
      _$StorageContainerFromJson(json);

  Map<String, dynamic> toJson() => _$StorageContainerToJson(this);

  @override
  List<Object> get props => [type, id, name];
}
