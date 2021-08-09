import 'package:json_annotation/json_annotation.dart';
import 'package:qr_smartstorage/resources/storage_container.dart';
import 'package:qr_smartstorage/resources/storage_item.dart';
import 'package:qr_smartstorage/resources/storage_root.dart';

@JsonSerializable()
abstract class Storage {
  abstract String type;
  abstract String id;
  abstract String name;

  Storage();

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
}
