import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:qr_smartstorage/resources/storage.dart';

part 'storage_root.g.dart';

@JsonSerializable()
class StorageRoot extends Equatable implements StorageWithChildren {
  final String id = "0";
  final String name = "Root";
  final String type;
  final List<Storage> children;

  StorageRoot(this.type, this.children);

  StorageRoot.empty()
      : type = "Root",
        children = [];

  StorageRoot.create({required List<Storage> children})
      : type = "Root",
        this.children = children;

  StorageRoot copy({String? withoutId}) {
    return StorageRoot.create(
      children: children
          .where((element) => withoutId == null || element.id != withoutId)
          .map((child) => child.copy(withoutId: withoutId))
          .toList(),
    );
  }

  factory StorageRoot.fromJson(Map<String, dynamic> json) =>
      _$StorageRootFromJson(json);

  Map<String, dynamic> toJson() => _$StorageRootToJson(this);

  @override
  List<Object> get props => [type, id, name, children];

  @override
  bool get stringify => true;
}
