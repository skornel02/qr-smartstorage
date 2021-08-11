import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown_editable_textinput/format_markdown.dart';
import 'package:markdown_editable_textinput/markdown_text_input.dart';
import 'package:qr_smartstorage/translations/locale_keys.g.dart';

class DescriptionWidget extends StatefulWidget {
  final String? description;
  final ValueSetter<String> saveDescription;

  const DescriptionWidget({
    Key? key,
    required this.description,
    required this.saveDescription,
  }) : super(key: key);

  @override
  _DescriptionWidgetState createState() =>
      _DescriptionWidgetState(false, description ?? tr(LocaleKeys.noDescription));
}

class _DescriptionWidgetState extends State<DescriptionWidget> {
  bool editing;
  String realDescription;

  _DescriptionWidgetState(this.editing, this.realDescription);

  void handleEdit() {
    setState(() {
      editing = true;
    });
  }

  void handleCloseEditor() {
    setState(() {
      editing = false;
      realDescription = this.widget.description ?? tr(LocaleKeys.noDescription);
    });
  }

  void handleSave() {
    this.widget.saveDescription(realDescription);
    setState(() {
      editing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!editing) {
      return Column(
        children: [
          Markdown(
            data: realDescription,
            shrinkWrap: true,
          ),
          IconButton(
            onPressed: handleEdit,
            icon: Icon(Icons.edit),
            iconSize: 16,
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: [
              IconButton(
                onPressed: handleSave,
                icon: Icon(Icons.save),
                iconSize: 16,
              ),
              IconButton(
                onPressed: handleCloseEditor,
                icon: Icon(Icons.close),
                iconSize: 16,
              )
            ],
          ),
          MarkdownTextInput(
            (String value) => setState(() => realDescription = value),
            realDescription,
            label: tr(LocaleKeys.description),
            maxLines: 10,
            actions: MarkdownType.values,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: MarkdownBody(
              data: realDescription,
              shrinkWrap: true,
            ),
          ),
        ],
      );
    }
  }
}
