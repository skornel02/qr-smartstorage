import 'package:flutter/material.dart';

PopupMenuButton createDropDownMenu({
  required VoidCallback handleEditName,
  required VoidCallback handleRemove,
}) {
  List<PopupMenuEntry> _menuItems = [
    PopupMenuItem(
      child: ListTile(
        leading: Icon(Icons.edit),
        title: Text('Edit title'),
        onTap: handleEditName,
      ),
    ),
    const PopupMenuDivider(),
    PopupMenuItem(
      child: ListTile(
        leading: Icon(Icons.delete),
        title: Text('Delete'),
        onTap: handleRemove,
      ),
    ),
  ];
  PopupMenuButton dropDownMenu = PopupMenuButton(
    itemBuilder: (context) => _menuItems,
  );
  return dropDownMenu;
}
