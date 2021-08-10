import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prompt_dialog/prompt_dialog.dart';
import 'package:qr_smartstorage/bloc/storage_bloc.dart';
import 'package:qr_smartstorage/description.dart';
import 'package:qr_smartstorage/helper/storage_helper.dart';
import 'package:qr_smartstorage/resources/storage_container.dart';
import 'package:qr_smartstorage/resources/storage_item.dart';
import 'package:qr_smartstorage/widgets/container_card.dart';
import 'package:qr_smartstorage/widgets/item_accordion.dart';
import 'package:qr_smartstorage/widgets/dropdown_menu.dart';
import 'package:uuid/uuid.dart';

class ContainerPage extends StatelessWidget {
  final StorageContainer _container;

  ContainerPage(this._container);

  void handleEditName(BuildContext context) async {
    String? name = await prompt(
      context,
      title: Text("New container name"),
      hintText: "Container name...",
      maxLines: 1,
    );
    if (name != null) {
      BlocProvider.of<StorageBloc>(context)
          .add(UpdateName(_container.id, name));
    }
  }

  void handleRemove(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    BlocProvider.of<StorageBloc>(context).add(DeleteStorageItem(_container.id));
  }

  void handleDescriptionUpdate(BuildContext context, String nextDescription) {
    print("New description: " + nextDescription);
    BlocProvider.of<StorageBloc>(context)
        .add(UpdateDescription(_container.id, nextDescription));
  }

  @override
  Widget build(BuildContext context) {
    List<StorageContainer> containers =
        getContainersFromParent(parent: _container);
    List<StorageItem> items = getItemsFromParent(parent: _container);

    return Scaffold(
      appBar: AppBar(
        title: Text(_container.name),
        actions: [
          createDropDownMenu(handleEditName: () {
            handleEditName(context);
          }, handleRemove: () {
            handleRemove(context);
          }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Wrap(
            runSpacing: 8.0,
            children: [
              DescriptionWidget(
                description: _container.description,
                saveDescription: (description) =>
                    handleDescriptionUpdate(context, description),
              ),
              Divider(),
              Text(
                'Containers',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: containers.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: ContainerCard(containers[index]),
                  );
                },
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              ),
              Text(
                'Items',
                style: TextStyle(fontSize: 24),
              ),
              ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Container(
                    child:
                        ItemAccordion(items[index], showParentContainer: false),
                  );
                },
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String? name = await prompt(
            context,
            title: Text("Create new item"),
            hintText: "Item name...",
            maxLines: 1,
          );
          print(name);
          if (name != null) {
            StorageBloc bloc = BlocProvider.of<StorageBloc>(context);
            bloc.add(AddItem(Uuid().v4(), name, _container.id));
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
