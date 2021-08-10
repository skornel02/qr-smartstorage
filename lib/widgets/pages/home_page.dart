import 'package:flutter/material.dart';
import 'package:qr_smartstorage/widgets/container_card.dart';
import 'package:qr_smartstorage/widgets/item_accordion.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Search', border: UnderlineInputBorder()),
            cursorColor: Colors.black26,
          ),
          actions: [
            // TODO: Do search on press
            IconButton(onPressed: () => print(controller.text), icon: Icon(Icons.search))
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.all_inbox_rounded),
              ),
              Tab(
                icon: Icon(Icons.wine_bar),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                ContainerCard(),
              ],
            ),
            Column(
              children: [
                ItemAccordion(showParentContainer: true),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.camera_alt),
          // TODO: Push to scanner page
          onPressed: () => print('To QR Scanner we go...'),
        ),
      ),
    );
  }
}
