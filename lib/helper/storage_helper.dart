import 'package:qr_smartstorage/resources/storage.dart';
import 'package:qr_smartstorage/resources/storage_container.dart';
import 'package:qr_smartstorage/resources/storage_root.dart';

StorageRoot addContainerToRoot({
  required StorageRoot root,
  required StorageContainer container,
  String? parentId,
}) {
  StorageRoot next = root.copy();

  Storage parent =
      (parentId != null ? findStorageItem(root: next, id: parentId) : next) ??
          next;

  if (parent.type == "Container") {
    StorageContainer c = parent as StorageContainer;
    c.children.add(container);
  } else if (parent.type == "Root") {
    StorageRoot r = parent as StorageRoot;
    r.children.add(container);
  }
  return next;
}

StorageRoot removeItemFromTree({
  required StorageRoot root,
  required String id,
}) {
  StorageRoot next = root.copy(withoutId: id);
  return next;
}

StorageContainer? findContainerFromId({
  required StorageRoot root,
  required String id,
}) {
  Storage? item = findStorageItem(root: root, id: id);
  if (item == null) return null;
  if (item.type != "Container") return null;
  return item as StorageContainer;
}

Storage? findStorageItem({
  required Storage root,
  required String id,
}) {
  if (root.id == id) return root;
  List<Storage> children = [];
  if (root.type == "Container") {
    StorageContainer c = root as StorageContainer;
    children = c.children;
  } else if (root.type == "Root") {
    StorageRoot r = root as StorageRoot;
    children = r.children;
  }
  var childrenResult = children
      .map((child) => findStorageItem(root: child, id: id))
      .where((element) => element != null);
  if (childrenResult.isEmpty) return null;
  return childrenResult.first;
}
