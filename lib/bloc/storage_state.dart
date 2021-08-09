part of 'storage_bloc.dart';

abstract class StorageState extends Equatable {
  const StorageState();

  @override
  List<Object> get props => [];
}

class StorageLoading extends StorageState {}

class StorageReady extends StorageState {
  final StorageRoot root;

  StorageReady(this.root);

  @override
  List<Object> get props => [root];
}
