part of 'storage_bloc.dart';

abstract class StorageEvent extends Equatable {
  const StorageEvent();

  @override
  List<Object> get props => [];
}

class UpdateRoot extends StorageEvent {
  final StorageRoot nextRoot;

  UpdateRoot(this.nextRoot);

  @override
  List<Object> get props => [nextRoot];
}

class AddContainer extends StorageEvent {
  final String id;
  final String name;
  final String? parentId;

  AddContainer(this.id, this.name, {this.parentId});

  @override
  List<Object> get props => [id, name];
}

class DeleteStorageItem extends StorageEvent {
  final String id;

  DeleteStorageItem(this.id);

  @override
  List<Object> get props => [id];
}

class AddItem extends StorageEvent {
  final String id;
  final String name;
  final String parentId;

  AddItem(this.id, this.name, this.parentId);

  @override
  List<Object> get props => [id, name, parentId];
}

class UpdateDescription extends StorageEvent {
  final String id;
  final String description;

  UpdateDescription(this.id, this.description);

  @override
  List<Object> get props => [id, description];
}

class UpdateName extends StorageEvent {
  final String id;
  final String name;

  UpdateName(this.id, this.name);

  @override
  List<Object> get props => [id, name];
}
