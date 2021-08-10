import 'package:flutter/material.dart';

PopupMenuButton dropDownMenu = PopupMenuButton(
  itemBuilder: (context) => _menuItems,
);

List<PopupMenuEntry> _menuItems = [
  const PopupMenuItem(
    child: ListTile(
      leading: Icon(Icons.edit),
      title: Text('Edit title'),
    ),
  ),
  const PopupMenuItem(
    child: ListTile(
      leading: Icon(Icons.edit),
      title: Text('Edit description'),
    ),
  ),
  const PopupMenuDivider(),
  const PopupMenuItem(
    child: ListTile(
      leading: Icon(Icons.delete),
      title: Text('Delete'),
    ),
  ),
];
