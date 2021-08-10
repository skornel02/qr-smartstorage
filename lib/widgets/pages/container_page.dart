import 'package:flutter/material.dart';
import 'package:qr_smartstorage/widgets/container_card.dart';
import 'package:qr_smartstorage/widgets/item_accordion.dart';
import 'package:qr_smartstorage/widgets/dropdown_menu.dart';

class ContainerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TODO: Get container name
        title: Text('Container'),
        actions: [
          dropDownMenu,
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Wrap(
          runSpacing: 8.0,
          children: [
            // TODO: Get description
            Text(
              'Lorem ipsum dolor sit amet',
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
            Divider(),
            // TODO: Get all containers and items
            Text(
              'Containers',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            ContainerCard(),
            Text(
              'Items',
              style: TextStyle(fontSize: 24),
            ),
            ItemAccordion(showParentContainer: false),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // TODO: Implement add new stuff functionality
        onPressed: () => print('Pressed'),
        child: Icon(Icons.add),
      ),
    );
  }
}
