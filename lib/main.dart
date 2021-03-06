import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_smartstorage/bloc/google_bloc.dart';
import 'package:qr_smartstorage/home.dart';
import 'package:qr_smartstorage/login.dart';
import 'package:qr_smartstorage/storage/google_repository.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      child: MyApp(),
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      useOnlyLangCode: true,
      supportedLocales: [
        Locale('en'),
        Locale('hu'),
      ],
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        ...context.localizationDelegates,
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('hu', ''),
        ...context.supportedLocales,
      ],
      locale: context.locale,
      title: 'QR Smart Storage',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: BlocProvider(
        create: (context) => GoogleBloc(),
        child: BlocBuilder<GoogleBloc, GoogleState>(builder: (context, state) {
          if (state.runtimeType == GoogleReadyToLoginState) {
            return Scaffold(
              body: LoginWidget(),
            );
          } else if (state.runtimeType == GoogleLoginWaitingState) {
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
          } else if (state.runtimeType == GoogleLoginSuccessfulState) {
            GoogleLoginSuccessfulState s = state as GoogleLoginSuccessfulState;
            GoogleRepository repository = GoogleRepository(s.accessToken);
            return Home(repository);
          }
          return Scaffold(
            body: Container(),
          );
        }),
      ),
    );
  }
}
