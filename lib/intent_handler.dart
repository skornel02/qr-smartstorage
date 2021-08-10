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
        return IntentHandler(child: child, context: context);
      },
    );
  }
}

class IntentHandler extends StatelessWidget {
  final Widget child;
  final BuildContext context;
  late final StreamSubscription? _sub;

  IntentHandler({Key? key, required this.child, required this.context})
      : super(key: key) {
    if (!kIsWeb) {
      _sub = uriLinkStream.listen((Uri? uri) {
        print("URI CHANGE: " + uri.toString());
        handleUri(uri);
      }, onError: (err) {});
      checkStarting();
    } else {
      _sub = null;
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
    return child;
  }
}
