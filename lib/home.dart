import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

import 'login.dart';
import 'message.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ParseUser currentUser;

  Future<ParseUser> getUser() async {
    currentUser = await ParseUser.currentUser() as ParseUser;
    return currentUser;
  }

  @override
  Widget build(BuildContext context) {
    void doUserLogout() async {
      var response = await currentUser.logout();
      if (response.success) {
        Message.showSuccess(
            context: context,
            message: 'User was successfully logout!',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
                (Route<dynamic> route) => false,
              );
            });
      } else {
        Message.showError(context: context, message: response.error.message);
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Parse Query Users"),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
        ),
        key: _scaffoldKey,
        body: FutureBuilder<List<ParseObject>>(
            future: doUserQuery(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                    child: Container(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator()),
                  );
                default:
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error...: ${snapshot.error.toString()}"),
                    );
                  } else {
                    if (snapshot.data.isEmpty) {
                      return Center(
                        child: Text('None user found'),
                      );
                    }

                    return SingleChildScrollView(
                        padding: const EdgeInsets.all(8.0),
                        physics: ScrollPhysics(),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(top: 10.0),
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    final user =
                                        snapshot.data[index] as ParseUser;
                                    final userVerified =
                                        user.emailVerified ?? false;
                                    return ListTile(
                                      title: Text(
                                          'Username: ${user.username} - Verified: ${userVerified.toString()}'),
                                      subtitle: Text(user.createdAt.toString()),
                                    );
                                  }),
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                height: 50,
                                child: ElevatedButton(
                                  child: const Text('Logout'),
                                  onPressed: () => doUserLogout(),
                                ),
                              ),
                            ]));
                  }
              }
            }));
  }

  Future<List<ParseObject>> doUserQuery() async {
    QueryBuilder<ParseUser> queryUsers =
        QueryBuilder<ParseUser>(ParseUser.forQuery());
    final ParseResponse apiResponse = await queryUsers.query();

    if (apiResponse.success && apiResponse.results != null) {
      return apiResponse.results;
    } else {
      return [];
    }
  }
}
