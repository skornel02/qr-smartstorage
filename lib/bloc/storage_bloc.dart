import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qr_smartstorage/helper/storage_helper.dart';
import 'package:qr_smartstorage/resources/storage_container.dart';
import 'package:qr_smartstorage/resources/storage_item.dart';
import 'package:qr_smartstorage/resources/storage_root.dart';
import 'package:qr_smartstorage/storage/repository.dart';

part 'storage_event.dart';
part 'storage_state.dart';

class StorageBloc extends Bloc<StorageEvent, StorageState> {
  Repository _repository;
  StorageRoot _root = StorageRoot.empty();

  StorageBloc(this._repository) : super(StorageLoading()) {
    _repository.getRoot().then((root) {
      this.add(UpdateRoot(root));
    });
  }

  @override
  Stream<StorageState> mapEventToState(
    StorageEvent event,
  ) async* {
    if (event.runtimeType == UpdateRoot) {
      UpdateRoot e = event as UpdateRoot;
      _root = e.nextRoot;
      yield StorageReady(_root);
    } else if (event.runtimeType == AddContainer) {
      AddContainer e = event as AddContainer;
      StorageContainer container = StorageContainer.empty(e.id, e.name);

      _root = addContainerToRoot(
        root: _root,
        container: container,
        parentId: e.parentId,
      );
      yield StorageReady(_root);
      await _repository.saveRoot(_root);
    } else if (event.runtimeType == DeleteStorageItem) {
      DeleteStorageItem e = event as DeleteStorageItem;
      _root = removeItemFromTree(root: _root, id: e.id);
      yield StorageReady(_root);
      await _repository.saveRoot(_root);
    } else if (event.runtimeType == AddItem) {
      AddItem e = event as AddItem;
      StorageItem item = StorageItem.empty(e.id, e.name);
      _root = addItemToParent(
        root: _root,
        item: item,
        parentId: e.parentId,
      );
      yield StorageReady(_root);
      await _repository.saveRoot(_root);
    } else if (event.runtimeType == UpdateDescription) {
      UpdateDescription e = event as UpdateDescription;
      _root = updateStorage(
        root: _root,
        id: e.id,
        description: e.description,
      );
      yield StorageReady(_root);
      await _repository.saveRoot(_root);
    } else if (event.runtimeType == UpdateName) {
      UpdateName e = event as UpdateName;
      _root = updateStorage(
        root: _root,
        id: e.id,
        name: e.name,
      );
      yield StorageReady(_root);
      await _repository.saveRoot(_root);
    }
  }
}
