import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_smartstorage/bloc/storage_bloc.dart';
import 'package:qr_smartstorage/helper/storage_helper.dart';
import 'package:qr_smartstorage/resources/storage_container.dart';
import 'package:qr_smartstorage/widgets/pages/container_page.dart';

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
          return ContainerPage(container);
        },
      ),
    );
  }
}
