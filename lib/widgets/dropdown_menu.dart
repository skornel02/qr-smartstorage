import 'package:flutter/material.dart';
import 'package:qr_smartstorage/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

PopupMenuButton createDropDownMenu({
  required VoidCallback handleEditName,
  required VoidCallback handleRemove,
}) {
  List<PopupMenuEntry> _menuItems = [
    PopupMenuItem(
      child: ListTile(
        leading: Icon(Icons.edit),
        title: Text(tr(LocaleKeys.editTitle)),
        onTap: handleEditName,
      ),
    ),
    const PopupMenuDivider(),
    PopupMenuItem(
      child: ListTile(
        leading: Icon(Icons.delete),
        title: Text(tr(LocaleKeys.delete)),
        onTap: handleRemove,
      ),
    ),
  ];
  PopupMenuButton dropDownMenu = PopupMenuButton(
    itemBuilder: (context) => _menuItems,
  );
  return dropDownMenu;
}
