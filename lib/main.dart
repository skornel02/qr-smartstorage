import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_smartstorage/bloc/google_bloc.dart';
import 'package:qr_smartstorage/home.dart';
import 'package:qr_smartstorage/login.dart';
import 'package:qr_smartstorage/storage/google_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => GoogleBloc(),
        child: Scaffold(
          body: BlocBuilder<GoogleBloc, GoogleState>(builder: (context, state) {
            if (state.runtimeType == GoogleReadyToLoginState) {
              return LoginWidget();
            } else if (state.runtimeType == GoogleLoginWaitingState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [CircularProgressIndicator()],
                  )
                ],
              );
            } else if (state.runtimeType == GoogleLoginSuccessfulState) {
              GoogleLoginSuccessfulState s =
                  state as GoogleLoginSuccessfulState;
              GoogleRepository repository = GoogleRepository(s.accessToken);
              return Home(repository);
            }
            return Container();
          }),
        ),
      ),
    );
  }
}
