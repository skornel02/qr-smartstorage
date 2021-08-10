import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContainerCard extends StatelessWidget {
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
            // TODO: Get container name
            child: Text('Doboz'),
          ),
          IconButton(
            // TODO: Send user to Container page on button press
              onPressed: () => print('Pressed'), icon: Icon(Icons.launch)),
        ],
      ),
    );
  }
}
