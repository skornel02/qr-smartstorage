import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_smartstorage/helper/qr_helper.dart';

import 'package:uni_links/uni_links.dart';

class IntentHandler extends StatefulWidget {
  final Widget child;

  const IntentHandler({Key? key, required this.child}) : super(key: key);

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
    return this.widget.child;
  }
}
