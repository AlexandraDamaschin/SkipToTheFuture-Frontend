import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:skip_to_the_future_app/translations/localizations.dart';
import '../common/message.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white24,
          title: Text(AppLocalizations.of(context).translate('sign_up')),
        ),
        body: LayoutBuilder(builder: (context, constrains) {
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text(
                        AppLocalizations.of(context)
                            .translate('user_registration'),
                        style: TextStyle(fontSize: 16)),
                  ),
                  SizedBox(height: (constrains.maxWidth < 700) ? 16 : 48),
                  Container(
                    margin: (constrains.maxWidth < 700)
                        ? EdgeInsets.only(right: 20, left: 20)
                        : EdgeInsets.only(right: 500, left: 500),
                    child: TextField(
                      controller: controllerUsername,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.none,
                      autocorrect: false,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          labelText: AppLocalizations.of(context)
                              .translate('username')),
                    ),
                  ),
                  SizedBox(height: (constrains.maxWidth < 700) ? 8 : 24),
                  Container(
                    margin: (constrains.maxWidth < 700)
                        ? EdgeInsets.only(right: 20, left: 20)
                        : EdgeInsets.only(right: 500, left: 500),
                    child: TextField(
                      controller: controllerEmail,
                      keyboardType: TextInputType.emailAddress,
                      textCapitalization: TextCapitalization.none,
                      autocorrect: false,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          labelText:
                              AppLocalizations.of(context).translate('email')),
                    ),
                  ),
                  SizedBox(height: (constrains.maxWidth < 700) ? 8 : 24),
                  Container(
                    margin: (constrains.maxWidth < 700)
                        ? EdgeInsets.only(right: 20, left: 20)
                        : EdgeInsets.only(right: 500, left: 500),
                    child: TextField(
                      controller: controllerPassword,
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
                  SizedBox(height: (constrains.maxWidth < 700) ? 8 : 24),
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
                        AppLocalizations.of(context).translate('register'),
                      ),
                      onPressed: () => doUserRegistration(),
                    ),
                  )
                ],
              ),
            ),
          );
        }));
  }

  void doUserRegistration() async {
    final username = controllerUsername.text.trim();
    final email = controllerEmail.text.trim();
    final password = controllerPassword.text.trim();

    final user = ParseUser.createUser(username, password, email);

    var response = await user.signUp();

    if (response.success) {
      await user.logout();

      Message.showSuccess(
          context: context,
          message:
              AppLocalizations.of(context).translate('success_registration'),
          onPressed: () async {
            Navigator.pop(context);
          });
    } else {
      Message.showError(context: context, message: response.error.message);
    }
  }
}
