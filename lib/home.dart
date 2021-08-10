import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_smartstorage/bloc/storage_bloc.dart';
import 'package:qr_smartstorage/intent_handler.dart';
import 'package:qr_smartstorage/storage/repository.dart';
import 'package:qr_smartstorage/widgets/pages/home_page.dart';

class Home extends StatelessWidget {
  final Repository repository;

  Home(this.repository, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    repository.getRoot().then((value) => print(value.toString()));
    return BlocProvider(
      create: (context) => StorageBloc(repository),
      child: BlocBuilder<StorageBloc, StorageState>(
        builder: (context, state) {
          if (state.runtimeType == StorageLoading) {
            return Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [CircularProgressIndicator()],
                  )
                ],
              ),
            );
          }
          return IntentHandler(child: HomePage());
        },
      ),
    );
  }
}
