import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prompt_dialog/prompt_dialog.dart';
import 'package:qr_smartstorage/bloc/storage_bloc.dart';
import 'package:qr_smartstorage/container_page.dart';
import 'package:qr_smartstorage/helper/storage_helper.dart';
import 'package:qr_smartstorage/resources/storage_container.dart';

Future<void> handleIncomingId(BuildContext context, String id) async {
  print("Handling incoming ID: " + id);

  StorageBloc bloc = BlocProvider.of<StorageBloc>(context);
  StorageReady state = bloc.state as StorageReady;
  StorageContainer? container = findContainerFromId(
    root: state.root,
    id: id,
  );

  if (container != null) {
    print("Found container: " + container.toString());
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ContainerPageWidget(bloc, id),
    ));
  } else {
    print("New container with id: " + id);
    String? name = await prompt(
      context,
      title: Text("Create new container"),
      hintText: "Container name...",
      maxLines: 1,
    );
    print(name);
    if (name != null) {
      bloc.add(AddContainer(id, name));
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ContainerPageWidget(bloc, id),
      ));
    }
  }
}
