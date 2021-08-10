import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prompt_dialog/prompt_dialog.dart';
import 'package:qr_smartstorage/bloc/storage_bloc.dart';
import 'package:qr_smartstorage/container_page.dart';
import 'package:qr_smartstorage/helper/qr_helper.dart';
import 'package:qr_smartstorage/helper/storage_helper.dart';
import 'package:qr_smartstorage/resources/storage_container.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class StorageAddTestWidget extends StatefulWidget {
  const StorageAddTestWidget({Key? key}) : super(key: key);

  @override
  _StorageAddTestStateWidget createState() => _StorageAddTestStateWidget();
}

class _StorageAddTestStateWidget extends State<StorageAddTestWidget> {
  final idController = TextEditingController(text: Uuid().v4());
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          color: Colors.deepPurple,
        ),
        Text(
          "Add container",
          textAlign: TextAlign.center,
        ),
        TextField(
          controller: idController,
        ),
        TextField(
          controller: nameController,
        ),
        ElevatedButton(
            onPressed: () {
              BlocProvider.of<StorageBloc>(context)
                  .add(AddContainer(idController.text, nameController.text));
              idController.text = Uuid().v4();
            },
            child: Text("add")),
        Divider(
          color: Colors.deepPurple,
        ),
        ElevatedButton(
            onPressed: () {
              StorageBloc bloc = BlocProvider.of<StorageBloc>(context);
              StorageReady state = bloc.state as StorageReady;
              state.root.children.forEach((container) {
                bloc.add(DeleteStorageItem(container.id));
              });
            },
            child: Text("Delete all container")),
        Divider(
          color: Colors.deepPurple,
        ),
        ElevatedButton(
            onPressed: () async {
              StorageBloc bloc = BlocProvider.of<StorageBloc>(context);
              StorageReady state = bloc.state as StorageReady;

              String code = await FlutterBarcodeScanner.scanBarcode(
                "#ff6666",
                "Cancel",
                false,
                ScanMode.DEFAULT,
              );
              print("QR CODE:" + code);
              if (code.startsWith("qrss://")) {
                code = code.replaceFirst("qrss://", "");
              }
              String id = code;
              print("Container ID: " + id);

              print("");
              print("");
              print("");
              handleIncomingId(context, id);
            },
            child: Text("Scan container")),
      ],
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    idController.dispose();
    super.dispose();
  }
}
