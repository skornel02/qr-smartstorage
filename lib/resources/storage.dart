import 'package:equatable/equatable.dart';
import 'package:qr_smartstorage/resources/storage_container.dart';
import 'package:qr_smartstorage/resources/storage_item.dart';
import 'package:qr_smartstorage/resources/storage_root.dart';

abstract class Storage extends Equatable {
  abstract final String type;
  abstract final String id;
  abstract final String name;

  Storage();

  Storage copy({String? withoutId});

  factory Storage.fromJson(Map<String, dynamic> json) {
    String? type = json["type"];
    if (type == null) throw new Exception("Incorrect type");
    switch (type) {
      case "Root":
        return StorageRoot.fromJson(json);
      case "Container":
        return StorageContainer.fromJson(json);
      case "Item":
        return StorageItem.fromJson(json);
      default:
        throw new Exception("Unknown type: $type");
    }
  }

  Map<String, dynamic> toJson();

  @override
  List<Object> get props => [type, id, name];
}
