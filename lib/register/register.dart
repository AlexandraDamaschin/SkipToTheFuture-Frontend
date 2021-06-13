import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
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
          title: const Text('Sign Up'),
        ),
        body: LayoutBuilder(builder: (context, constrains) {
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: const Text('Volunteer with us',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(
                    height: (constrains.maxWidth < 700) ? 16 : 48,
                  ),
                  Center(
                    child: const Text('User registration',
                        style: TextStyle(fontSize: 16)),
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
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.none,
                      autocorrect: false,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          labelText: 'Username'),
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
                          labelText: 'Password'),
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
                      child: const Text('Sign Up'),
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
          message: 'User was successfully created!',
          onPressed: () async {
            Navigator.pop(context);
          });
    } else {
      Message.showError(context: context, message: response.error.message);
    }
  }
}
