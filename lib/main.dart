import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:skip_to_the_future_app/login/login.dart';
import 'common/constants.dart';
import 'projects/projects.dart';
import 'translations/localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Parse().initialize(kParseApplicationId, kParseApiUrl,
      clientKey: kParseClientKey);

  runApp(MaterialApp(title: 'Sign Up', home: MyApp()));
}

class MyApp extends StatelessWidget {
  Future<bool> hasUserLogged() async {
    ParseUser currentUser = await ParseUser.currentUser() as ParseUser;
    if (currentUser == null) {
      return false;
    }
    final ParseResponse parseResponse =
        await ParseUser.getCurrentUserFromServer(
            currentUser.get<String>('sessionToken'));

    if (!parseResponse.success) {
      await currentUser.logout();
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Volunteer with us!',
      supportedLocales: [
        Locale('en', 'US'),
        Locale('ro', ''),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: FutureBuilder<bool>(
          future: hasUserLogged(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Scaffold(
                  body: Center(
                    child: Container(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator()),
                  ),
                );
                break;
              default:
                if (snapshot.hasData && snapshot.data) {
                  return ProjectsPage();
                } else {
                  return LoginPage();
                }
            }
          }),
    );
  }
}
