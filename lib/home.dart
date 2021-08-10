import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_smartstorage/bloc/storage_bloc.dart';
import 'package:qr_smartstorage/intent_handler.dart';
import 'package:qr_smartstorage/storage.dart';
import 'package:qr_smartstorage/storage/repository.dart';

class Home extends StatelessWidget {
  final Repository repository;

  const Home(this.repository, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    repository.getRoot().then((value) => print(value.toString()));
    return BlocProvider(
      create: (context) => StorageBloc(repository),
      child: IntentHandlerWidget(
        child: BlocBuilder<StorageBloc, StorageState>(
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
            return StorageWidget();
          },
        ),
      ),
    );
  }
}
