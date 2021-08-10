import 'package:flutter/material.dart';
import 'package:qr_smartstorage/widgets/dropdown_menu.dart';

class ItemAccordion extends StatelessWidget {
  final bool showParentContainer;

  ItemAccordion({required this.showParentContainer});

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
        title:
            // TODO: Get item name
            Text('Lorem ipsum dolor sit amet'),
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
            child: Column(
              children: [
                Row(children: [Text('Lorem ipsum dolor sit amet')]),
                Row(
                  children: [
                    Text('Created: 2022. 04. 07. 19:02:23'),
                  ],
                ),
                showParentContainer
                    ? Row(
                        children: [
                          // TODO: Get parent container name
                          Text('In BuksiSzekrény'),
                          // TODO: Send user to container page
                          IconButton(
                            onPressed: () => print('Pressed'),
                            icon: Icon(Icons.launch),
                          ),
                        ],
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ),
        ],
        initiallyExpanded: false,
        trailing: dropDownMenu,
      ),
    );
  }
}
