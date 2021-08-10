import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qr_smartstorage/helper/storage_helper.dart';
import 'package:qr_smartstorage/resources/storage_container.dart';
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
      await _repository.saveRoot(_root);
      yield StorageReady(_root);
    } else if (event.runtimeType == DeleteStorageItem) {
      DeleteStorageItem e = event as DeleteStorageItem;
      _root = removeItemFromTree(root: _root, id: e.id);
      await _repository.saveRoot(_root);
      yield StorageReady(_root);
    }
  }
}
