import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prompt_dialog/prompt_dialog.dart';
import 'package:qr_smartstorage/bloc/storage_bloc.dart';
import 'package:qr_smartstorage/description.dart';
import 'package:qr_smartstorage/helper/qr_helper.dart';
import 'package:qr_smartstorage/helper/storage_helper.dart';
import 'package:qr_smartstorage/resources/storage.dart';
import 'package:qr_smartstorage/resources/storage_container.dart';
import 'package:qr_smartstorage/resources/storage_item.dart';
import 'package:qr_smartstorage/widgets/dropdown_menu.dart';

class ItemAccordion extends StatelessWidget {
  final StorageItem _item;
  final bool showParentContainer;

  ItemAccordion(this._item, {required this.showParentContainer});

  void handleEditName(BuildContext context) async {
    String? name = await prompt(
      context,
      title: Text("New container name"),
      hintText: "Container name...",
      maxLines: 1,
    );
    if (name != null) {
      BlocProvider.of<StorageBloc>(context).add(UpdateName(_item.id, name));
    }
  }

  void handleRemove(BuildContext context) {
    BlocProvider.of<StorageBloc>(context).add(DeleteStorageItem(_item.id));
  }

  void handleSaveDescription(BuildContext context, String nextDescription) {
    BlocProvider.of<StorageBloc>(context)
        .add(UpdateDescription(_item.id, nextDescription));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 5,
            spreadRadius: 2,
          )
        ],
      ),
      child: ExpansionTile(
        title: Text(_item.name),
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
            child: Column(
              children: [
                DescriptionWidget(
                  description: _item.description,
                  saveDescription: (description) =>
                      handleSaveDescription(context, description),
                ),
                Row(
                  children: [
                    Text(_item.creation.toString()),
                  ],
                ),
                showParentContainer
                    ? BlocBuilder<StorageBloc, StorageState>(
                        builder: (context, s) {
                        StorageReady state = s as StorageReady;
                        Storage parent =
                            getParentOfItem(root: state.root, item: _item);

                        if (parent.type == "Root") {
                          return Text("Lost");
                        } else {
                          StorageContainer container =
                              parent as StorageContainer;
                          return Row(
                            children: [
                              Text(container.name),
                              IconButton(
                                onPressed: () =>
                                    handleIncomingId(context, container.id),
                                icon: Icon(Icons.launch),
                              ),
                            ],
                          );
                        }
                      })
                    : SizedBox.shrink(),
              ],
            ),
          ),
        ],
        initiallyExpanded: kIsWeb,
        trailing: createDropDownMenu(handleEditName: () {
          handleEditName(context);
        }, handleRemove: () {
          handleRemove(context);
        }),
      ),
    );
  }
}
