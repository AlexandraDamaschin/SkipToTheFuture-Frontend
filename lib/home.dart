import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:skip_to_the_future_app/projects/projects.dart';
import 'package:skip_to_the_future_app/user/user_info.dart';

import 'common/message.dart';

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
            onPressed: () {});
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
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            physics: ScrollPhysics(),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                      height: 50,
                      child: ElevatedButton(
                          child: const Text('Find more about our projects'),
                          onPressed: () => {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ListPage()),
                                  (Route<dynamic> route) => false,
                                )
                              })),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                      height: 50,
                      child: ElevatedButton(
                          child: const Text('User details'),
                          onPressed: () => {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserInfoPage()),
                                  (Route<dynamic> route) => false,
                                )
                              }))
                ])));
  }
}
