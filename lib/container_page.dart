import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_smartstorage/bloc/storage_bloc.dart';
import 'package:qr_smartstorage/helper/storage_helper.dart';
import 'package:qr_smartstorage/resources/storage_container.dart';

class ContainerPageWidget extends StatelessWidget {
  final StorageBloc _storageBloc;
  final String _containerId;

  const ContainerPageWidget(this._storageBloc, this._containerId, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _storageBloc,
      child: BlocBuilder<StorageBloc, StorageState>(
        builder: (context, s) {
          StorageReady state = s as StorageReady;
          StorageContainer? co =
              findContainerFromId(root: state.root, id: _containerId);
          if (co == null) {
            return Container();
          }
          StorageContainer container = co;
          return AppBar(
            title: Text(container.name),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  BlocProvider.of<StorageBloc>(context)
                      .add(DeleteStorageItem(container.id));
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
