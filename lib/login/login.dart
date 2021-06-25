import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:skip_to_the_future_app/projects/projects.dart';
import 'package:skip_to_the_future_app/register/register.dart';
import 'package:skip_to_the_future_app/login/reset_password.dart';
import 'package:skip_to_the_future_app/translations/localizations.dart';
import '../common/message.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white24,
          title:
              Text(AppLocalizations.of(context).translate('volunteer_with_us')),
        ),
        body: LayoutBuilder(builder: (context, constrains) {
          return Center(
              child: SingleChildScrollView(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Text(
                            AppLocalizations.of(context)
                                .translate('volunteer_with_us'),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: (constrains.maxWidth < 700) ? 16 : 48,
                      ),
                      Container(
                        margin: (constrains.maxWidth < 700)
                            ? EdgeInsets.only(right: 20, left: 20)
                            : EdgeInsets.only(right: 500, left: 500),
                        child: TextField(
                          controller: controllerUsername,
                          enabled: !isLoggedIn,
                          keyboardType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.none,
                          autocorrect: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              labelText: AppLocalizations.of(context)
                                  .translate('username')),
                        ),
                      ),
                      SizedBox(
                        height: (constrains.maxWidth < 700) ? 8 : 24,
                      ),
                      Container(
                        margin: (constrains.maxWidth < 700)
                            ? EdgeInsets.only(right: 20, left: 20)
                            : EdgeInsets.only(right: 500, left: 500),
                        child: TextField(
                          controller: controllerPassword,
                          enabled: !isLoggedIn,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.none,
                          autocorrect: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              labelText: AppLocalizations.of(context)
                                  .translate('password')),
                        ),
                      ),
                      SizedBox(
                        height: (constrains.maxWidth < 700) ? 16 : 28,
                      ),
                      Container(
                        height: 50,
                        margin: (constrains.maxWidth < 700)
                            ? EdgeInsets.only(right: 20, left: 20)
                            : EdgeInsets.only(right: 500, left: 500),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white24,
                          ),
                          child: Text(
                              AppLocalizations.of(context).translate('login')),
                          onPressed: isLoggedIn ? null : () => doUserLogin(),
                        ),
                      ),
                      SizedBox(
                        height: (constrains.maxWidth < 700) ? 16 : 28,
                      ),
                      Container(
                        height: 50,
                        margin: (constrains.maxWidth < 700)
                            ? EdgeInsets.only(right: 20, left: 20)
                            : EdgeInsets.only(right: 500, left: 500),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white24,
                          ),
                          child: Text(AppLocalizations.of(context)
                              .translate('sign_up')),
                          onPressed: () => navigateToSignUp(),
                        ),
                      ),
                      SizedBox(
                        height: (constrains.maxWidth < 700) ? 16 : 28,
                      ),
                      Container(
                          height: 50,
                          margin: (constrains.maxWidth < 700)
                              ? EdgeInsets.only(right: 20, left: 20)
                              : EdgeInsets.only(right: 500, left: 500),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white24,
                            ),
                            child: Text(AppLocalizations.of(context)
                                .translate('reset_password')),
                            onPressed: () => navigateToResetPassword(),
                          ))
                    ],
                  )));
        }));
  }

  void doUserLogin() async {
    final username = controllerUsername.text.trim();
    final password = controllerPassword.text.trim();

    final user = ParseUser(username, password, null);

    var response = await user.login();

    if (response.success) {
      navigateToUser();
    } else {
      Message.showError(context: context, message: response.error.message);
    }
  }

  void navigateToUser() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => ProjectsPage()),
      (Route<dynamic> route) => false,
    );
  }

  void navigateToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );
  }

  void navigateToResetPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResetPasswordPage()),
    );
  }
}
