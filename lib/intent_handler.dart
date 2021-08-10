import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_smartstorage/bloc/storage_bloc.dart';
import 'package:qr_smartstorage/helper/qr_helper.dart';

import 'package:uni_links/uni_links.dart';

class IntentHandlerWidget extends StatelessWidget {
  final Widget child;

  const IntentHandlerWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StorageBloc, StorageState>(
      builder: (context, state) {
        if (state.runtimeType == StorageLoading) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CircularProgressIndicator()],
              )
            ],
          );
        }
        return Column(
          children: [IntentHandler(), child],
        );
      },
    );
  }
}

class IntentHandler extends StatefulWidget {
  const IntentHandler({Key? key}) : super(key: key);

  @override
  _IntentHandlerState createState() => _IntentHandlerState();
}

class _IntentHandlerState extends State<IntentHandler> {
  _IntentHandlerState() {
    if (!kIsWeb) {
      uriLinkStream.listen((Uri? uri) {
        print("URI CHANGE: " + uri.toString());
        handleUri(uri);
      }, onError: (err) {});
      checkStarting();
    }
  }

  void checkStarting() async {
    try {
      final initialUri = await getInitialUri();
      print("INITIAL URI: " + initialUri.toString());
      handleUri(initialUri);
    } on FormatException {}
  }

  void handleUri(Uri? uri) {
    print(uri);
    if (uri != null &&
        uri.scheme.toLowerCase() == "qrss" &&
        uri.host.startsWith("s")) {
      handleIncomingId(context, uri.host);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
