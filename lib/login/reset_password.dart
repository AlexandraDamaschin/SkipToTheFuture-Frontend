import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import '../common/message.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final controllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white24,
          title: Text('Reset Password'),
        ),
        body: LayoutBuilder(builder: (context, constrains) {
          return Center(
              child: SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                  Center(
                    child: const Text('Reset password',
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
                    controller: controllerEmail,
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    autocorrect: false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        labelText: 'E-mail'),
                  ),
                ),
                SizedBox(
                  height: (constrains.maxWidth < 700) ? 8 : 24,
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
                    child: const Text('Reset Password'),
                    onPressed: () => doUserResetPassword(),
                  ),
                )
              ],
            ),
          ));
        }));
  }

  void doUserResetPassword() async {
    final ParseUser user = ParseUser(null, null, controllerEmail.text.trim());
    final ParseResponse parseResponse = await user.requestPasswordReset();
    if (parseResponse.success) {
      Message.showSuccess(
          context: context,
          message: 'Password reset instructions have been sent to email!',
          onPressed: () {
            Navigator.of(context).pop();
          });
    } else {
      Message.showError(context: context, message: parseResponse.error.message);
    }
  }
}
