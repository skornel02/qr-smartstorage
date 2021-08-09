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
