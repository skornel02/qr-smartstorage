import 'package:qr_smartstorage/resources/storage_root.dart';
import 'dart:convert';

abstract class Repository {
  Future<StorageRoot> getRoot();
  Future<void> saveRoot(StorageRoot root);

  StorageRoot parseRoot(String json) {
    try {
      print("PARSING: " + json);

      if (json == "{}") return StorageRoot.empty();

      Map<String, dynamic> jsonData = jsonDecode(json);

      StorageRoot root = StorageRoot.fromJson(jsonData);
      return root;
    } catch (err, stack) {
      print("Error while loading: " + err.toString());
      print(stack);
      return StorageRoot.empty();
    }
  }
}
