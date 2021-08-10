import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_smartstorage/helper/qr_helper.dart';
import 'package:qr_smartstorage/resources/storage_container.dart';

class ContainerCard extends StatelessWidget {
  final StorageContainer _container;

  ContainerCard(this._container);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      shadowColor: Colors.black.withAlpha(40),
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(_container.name),
          ),
          IconButton(
              onPressed: () => handleIncomingId(context, _container.id),
              icon: Icon(Icons.launch)),
        ],
      ),
    );
  }
}
