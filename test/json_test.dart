import 'package:flutter_test/flutter_test.dart';
import 'package:qr_smartstorage/resources/storage.dart';
import 'package:qr_smartstorage/resources/storage_container.dart';
import 'package:qr_smartstorage/resources/storage_item.dart';
import 'package:qr_smartstorage/resources/storage_root.dart';

import 'dart:convert';

import 'package:uuid/uuid.dart';

void main() {
  test("Test some stuff", () {
    StorageRoot root = StorageRoot();
    StorageContainer container = new StorageContainer("1", "Test");
    root.children.add(container);

    StorageItem item = new StorageItem(Uuid().v4(), "Item");
    container.children.add(item);

    Storage sajt = root;
    String json = jsonEncode(sajt.toJson());
    print(json);

    Storage decodedRip = Storage.fromJson(jsonDecode(json));
    print(decodedRip.toJson());
    print(decodedRip.runtimeType);

    expect(decodedRip.runtimeType, StorageRoot);
    StorageRoot decoded = decodedRip as StorageRoot;
    expect(decoded.children.length, 1);
    expect(decoded.children[0].runtimeType, StorageContainer);

    StorageContainer decodedChild = decoded.children[0] as StorageContainer;
    expect(decodedChild.children.length, 1);
    expect(decodedChild.children[0].runtimeType, StorageItem);
  });
}
