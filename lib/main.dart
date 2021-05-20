import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:skip_to_the_future_app/login.dart';
import 'package:skip_to_the_future_app/register.dart';

import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final keyApplicationId = kParseApplicationId;
  final keyClientKey = kParseClientKey;
  final keyParseServerUrl = kParseApiUrl;

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, debug: true);
  runApp(MaterialApp(
    title: 'Flutter SignUp',
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                child: Text('Register'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
              ),
              SizedBox(
                height: 16,
              ),
              ElevatedButton(
                child: Text('Login'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
