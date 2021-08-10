import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:qr_smartstorage/resources/storage.dart';

part 'storage_container.g.dart';

@JsonSerializable()
class StorageContainer extends Equatable implements Storage {
  final String type;
  final String id;
  final String name;
  final String? description;

  final List<Storage> children;

  StorageContainer(
      this.type, this.id, this.name, this.description, this.children);

  StorageContainer.empty(this.id, this.name)
      : this.type = "Container",
        this.description = null,
        this.children = [];

  StorageContainer.create(
      {required String id,
      required String name,
      String? description,
      required List<Storage> children})
      : this.type = "Container",
        this.id = id,
        this.name = name,
        this.description = description,
        this.children = children;

  StorageContainer copy({String? withoutId}) {
    return StorageContainer.create(
      id: this.id,
      name: this.name,
      description: this.description,
      children: this
          .children
          .where((element) => withoutId == null || element.id != withoutId)
          .map((child) => child.copy())
          .toList(),
    );
  }

  factory StorageContainer.fromJson(Map<String, dynamic> json) =>
      _$StorageContainerFromJson(json);

  Map<String, dynamic> toJson() => _$StorageContainerToJson(this);

  @override
  List<Object> get props => [type, id, name, children];

  @override
  bool get stringify => true;
}
