import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:skip_to_the_future_app/common/message.dart';
import 'package:skip_to_the_future_app/login/login.dart';

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ParseUser currentUser;

  Future<ParseUser> getUser() async {
    currentUser = await ParseUser.currentUser() as ParseUser;
    return currentUser;
  }

  @override
  Widget build(BuildContext context) {
    void doUserLogout() async {
      ParseUser currentUser = await ParseUser.currentUser() as ParseUser;
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
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("User info"),
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

                    final user = snapshot.data[3] as ParseUser;

                    return SafeArea(
                        child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      NetworkImage("add you image URL here "),
                                  fit: BoxFit.cover)),
                          child: Container(
                            width: double.infinity,
                            height: 200,
                            child: Container(
                              alignment: Alignment(0.0, 2.5),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "Add you profile DP image URL here "),
                                radius: 60.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                        Text(
                          "${user.username}",
                          style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.blueGrey,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Sibiu",
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black45,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${user.emailAddress}",
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black45,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 8.0),
                            elevation: 2.0,
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 30),
                                child: Text(
                                  "Skill Sets",
                                  style: TextStyle(
                                      letterSpacing: 2.0,
                                      fontWeight: FontWeight.w300),
                                ))),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "App Developer || Digital Marketer",
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.black45,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.w300),
                        ),
                        Card(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Project",
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        "15",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.w300),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Followers",
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        "2000",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.w300),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RaisedButton(
                                onPressed: () {},
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80.0),
                                ),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Colors.pink,
                                          Colors.redAccent
                                        ]),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth: 100.0,
                                      maxHeight: 40.0,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Contact me",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          letterSpacing: 2.0,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ),
                              ),
                              RaisedButton(
                                onPressed: () {},
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80.0),
                                ),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Colors.pink,
                                          Colors.redAccent
                                        ]),
                                    borderRadius: BorderRadius.circular(80.0),
                                  ),
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth: 100.0,
                                      maxHeight: 40.0,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Portfolio",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          letterSpacing: 2.0,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              )
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RaisedButton(
                                onPressed: () => doUserLogout(),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(80.0),
                                ),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Colors.pink,
                                          Colors.redAccent
                                        ]),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth: 100.0,
                                      maxHeight: 40.0,
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Logout",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          letterSpacing: 2.0,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                      ],
                    ));
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
