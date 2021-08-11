import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_smartstorage/bloc/google_bloc.dart';
import 'package:qr_smartstorage/bloc/storage_bloc.dart';
import 'package:qr_smartstorage/test/add_test.dart';
import 'package:qr_smartstorage/translations/locale_keys.g.dart';

class StorageWidget extends StatelessWidget {
  const StorageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StorageBloc, StorageState>(builder: (context, s) {
      StorageReady state = s as StorageReady;

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(state.root.toString()),
              )
            ],
          ),
          ElevatedButton(
              onPressed: () {
                BlocProvider.of<GoogleBloc>(context)
                    .add(GoogleLogoutButtonPressedEvent());
              },
              child: Text(tr(LocaleKeys.logOut))),
          StorageAddTestWidget()
        ],
      );
    });
  }
}
