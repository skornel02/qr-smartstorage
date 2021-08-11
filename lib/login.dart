import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:qr_smartstorage/bloc/google_bloc.dart';
import 'package:qr_smartstorage/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({Key? key}) : super(key: key);

  void autoLogin(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? enabled = prefs.getBool("GoogleEnabled");
    print(enabled);
    if (enabled ?? false) {
      BlocProvider.of<GoogleBloc>(context).add(GoogleLoginButtonPressedEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          tr(LocaleKeys.logIn),
        ),
        SignInButton(
          Buttons.Google,
          onPressed: () {
            BlocProvider.of<GoogleBloc>(context)
                .add(GoogleLoginButtonPressedEvent());
          },
        ),
        BlocBuilder<GoogleBloc, GoogleState>(
          builder: (context, s) {
            if (s.runtimeType == GoogleReadyToLoginState) {
              autoLogin(context);
            }
            return Container();
          },
        ),
      ],
    );
  }
}
