import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qr_smartstorage/resources/storage_root.dart';
import 'package:qr_smartstorage/storage/repository.dart';

part 'storage_event.dart';
part 'storage_state.dart';

class StorageBloc extends Bloc<StorageEvent, StorageState> {
  Repository _repository;
  StorageRoot _root = StorageRoot();

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
    }
  }
}
