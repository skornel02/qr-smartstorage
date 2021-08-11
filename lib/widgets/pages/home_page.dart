import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_smartstorage/bloc/google_bloc.dart';
import 'package:qr_smartstorage/bloc/storage_bloc.dart';
import 'package:qr_smartstorage/helper/storage_helper.dart';
import 'package:qr_smartstorage/qr_view.dart';
import 'package:qr_smartstorage/resources/storage_container.dart';
import 'package:qr_smartstorage/resources/storage_item.dart';
import 'package:qr_smartstorage/translations/locale_keys.g.dart';
import 'package:qr_smartstorage/widgets/container_card.dart';
import 'package:qr_smartstorage/widgets/item_accordion.dart';
import 'package:rxdart/transformers.dart';
import 'package:easy_localization/easy_localization.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controller = TextEditingController();
  final _textUpdates = StreamController<String>();
  String _searchText = "";

  _HomePageState() {
    controller.addListener(() {
      _textUpdates.add(controller.text);
    });
    _textUpdates.stream
        .throttleTime(const Duration(milliseconds: 700))
        .forEach((s) {
      setState(() {
        _searchText = s;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                BlocProvider.of<GoogleBloc>(context)
                    .add(GoogleLogoutButtonPressedEvent());
              },
              icon: Icon(Icons.logout)),
          title: TextField(
            controller: controller,
            decoration: InputDecoration(
                hintText: tr(LocaleKeys.search), border: UnderlineInputBorder()),
            cursorColor: Colors.black26,
          ),
          actions: [
            // TODO: Do search on press
            IconButton(
                onPressed: () {
                  print(controller.text);
                  setState(() {});
                },
                icon: Icon(Icons.search))
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
            BlocBuilder<StorageBloc, StorageState>(builder: (context, s) {
              StorageReady state = s as StorageReady;
              String? matcher = (_searchText.length == 0 || _searchText.isEmpty)
                  ? null
                  : _searchText;

              List<StorageContainer> containers = getContainersFromParent(
                parent: state.root,
                nested: true,
                match: matcher,
              );

              return SingleChildScrollView(
                child: ListView.builder(
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
              );
            }),
            BlocBuilder<StorageBloc, StorageState>(builder: (context, s) {
              StorageReady state = s as StorageReady;
              String? matcher = (_searchText.length == 0 || _searchText.isEmpty)
                  ? null
                  : _searchText;

              List<StorageItem> items = getItemsFromParent(
                parent: state.root,
                nested: true,
                match: matcher,
              );

              return SingleChildScrollView(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: ItemAccordion(
                        items[index],
                        showParentContainer: true,
                      ),
                    );
                  },
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                ),
              );
            }),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.camera_alt),
          onPressed: () {
            StorageBloc bloc = BlocProvider.of<StorageBloc>(context);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: bloc,
                child: QRViewExample(),
              ),
            ));
          },
        ),
      ),
    );
  }
}
