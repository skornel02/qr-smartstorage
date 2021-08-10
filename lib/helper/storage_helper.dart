import 'package:qr_smartstorage/resources/storage.dart';
import 'package:qr_smartstorage/resources/storage_container.dart';
import 'package:qr_smartstorage/resources/storage_item.dart';
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

StorageRoot addItemToParent({
  required StorageRoot root,
  required StorageItem item,
  required String parentId,
}) {
  StorageRoot next = root.copy();
  StorageContainer? parent = findContainerFromId(root: next, id: parentId);
  if (parent != null) {
    parent.children.add(item);
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

StorageRoot updateStorage({
  required StorageRoot root,
  required String id,
  String? description,
  String? name,
}) {
  Storage? original = findStorageItem(root: root, id: id);
  print("Original: " + original.toString());
  StorageWithChildren? originalParent = getParentOfStorage(root: root, id: id);
  print("originalParent: " + originalParent.toString());

  StorageRoot next = root.copy(withoutId: id);
  if (original != null && originalParent != null && originalParent.id != id) {
    StorageWithChildren sc = findStorageItem(root: next, id: originalParent.id)
        as StorageWithChildren;

    if (original.type == "Container") {
      StorageContainer originalContainer = (original as StorageContainer);
      StorageContainer container = StorageContainer.create(
        id: originalContainer.id,
        name: name ?? originalContainer.name,
        description: description ?? originalContainer.description,
        children: originalContainer.children.map((e) => e.copy()).toList(),
      );
      sc.children.add(container);
    } else if (original.type == "Item") {
      StorageItem originalItem = (original as StorageItem);
      StorageItem item = StorageItem.create(
        id: originalItem.id,
        name: name ?? originalItem.name,
        description: description ?? originalItem.description,
        creation: originalItem.creation,
      );
      sc.children.add(item);
    }
  }

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
  if (root.type == "Container" || root.type == "Root") {
    StorageWithChildren sc = root as StorageWithChildren;
    children = sc.children;
  }
  var childrenResult = children
      .map((child) => findStorageItem(root: child, id: id))
      .where((element) => element != null);
  if (childrenResult.isEmpty) return null;
  return childrenResult.first;
}

List<StorageContainer> getContainersFromParent({
  required Storage parent,
  bool nested = false,
  String? match,
}) {
  List<StorageContainer> containers = [];
  if (parent.type == "Root" || parent.type == "Container") {
    StorageWithChildren root = parent as StorageWithChildren;
    containers.addAll(
      root.children
          .where((storage) => storage.type == "Container")
          .map((e) => e as StorageContainer),
    );
    if (nested) {
      root.children.forEach((child) {
        containers.addAll(getContainersFromParent(parent: child));
      });
    }
  }
  if (match == null) {
    return containers;
  } else {
    return containers
        .where((element) =>
            element.name.toLowerCase().contains(match.toLowerCase()) ||
            (element.description ?? "")
                .toLowerCase()
                .contains(match.toLowerCase()))
        .toList();
  }
}

List<StorageItem> getItemsFromParent({
  required Storage parent,
  bool nested = false,
  String? match,
}) {
  List<StorageItem> containers = [];
  if (parent.type == "Root" || parent.type == "Container") {
    StorageWithChildren root = parent as StorageWithChildren;
    containers.addAll(
      root.children
          .where((storage) => storage.type == "Item")
          .map((e) => e as StorageItem),
    );
    if (nested) {
      root.children.forEach((child) {
        containers.addAll(getItemsFromParent(parent: child));
      });
    }
  }
  if (match == null) {
    return containers;
  } else {
    return containers
        .where((element) =>
            element.name.contains(match) ||
            (element.description ?? "").contains(match))
        .toList();
  }
}

StorageWithChildren? getParentOfStorage({
  required Storage root,
  required String id,
}) {
  List<Storage> children = [];

  if (root.type == "Item") {
    return null;
  } else if (root.type == "Container" || root.type == "Root") {
    StorageWithChildren c = root as StorageWithChildren;
    if (c.children.where((element) => element.id == id).isNotEmpty) return c;

    children.addAll(c.children);
  }

  var childrenResult = children
      .map((child) => getParentOfStorage(root: child, id: id))
      .where((element) => element != null);
  if (childrenResult.isEmpty) return null;
  return childrenResult.first;
}

Storage getParentOfItem({
  required Storage root,
  required StorageItem item,
}) {
  List<StorageContainer> containers =
      getContainersFromParent(parent: root, nested: true);

  var container =
      containers.where((container) => container.children.contains(item));

  if (containers.isEmpty) {
    return root;
  } else {
    return container.first;
  }
}
