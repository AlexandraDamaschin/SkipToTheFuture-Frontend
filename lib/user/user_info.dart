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
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("Profile"),
          elevation: 0.1,
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          centerTitle: true,
        ),
        key: _scaffoldKey,
        body: LayoutBuilder(builder: (context, constrains) {
          return FutureBuilder<List<ParseObject>>(
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
                          child: Text('No user found'),
                        );
                      }

                      final user = snapshot.data[0] as ParseUser;

                      return SingleChildScrollView(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage("images/volunteer.jpeg"),
                                        fit: (constrains.maxWidth < 700)
                                            ? BoxFit.cover
                                            : BoxFit.contain)),
                                child: Container(
                                  width: double.infinity,
                                  height:
                                      (constrains.maxWidth < 700) ? 200 : 400,
                                  child: Container(
                                    alignment: Alignment(0.0, 2.5),
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          "https://we-help.ro/wp-content/uploads/2020/01/80956143_2619084438140865_3308753349259558912_o-1-150x150.jpg"),
                                      radius: (constrains.maxWidth < 700)
                                          ? 60.0
                                          : 100.0,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height:
                                      (constrains.maxWidth < 700) ? 80 : 240),
                              Text("${user.username}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400)),
                              SizedBox(
                                  height:
                                      (constrains.maxWidth < 700) ? 10 : 30),
                              Text(
                                "Sibiu",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                              SizedBox(
                                  height:
                                      (constrains.maxWidth < 700) ? 10 : 30),
                              Card(
                                  color: Colors.white70,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: (constrains.maxWidth < 700)
                                          ? 20
                                          : 850,
                                      vertical: 8.0),
                                  elevation: 2.0,
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 30),
                                      child: Text(
                                        "Skill Sets",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.blueAccent,
                                        ),
                                      ))),
                              SizedBox(
                                  height:
                                      (constrains.maxWidth < 700) ? 10 : 30),
                              Text(
                                "Public Speaking || Digital Marketer",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                              Card(
                                  color: Colors.white70,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: (constrains.maxWidth < 700)
                                          ? 20
                                          : 850,
                                      vertical: 8.0),
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Text(
                                                  "Projects",
                                                  style: TextStyle(
                                                      color: Colors.blueAccent,
                                                      fontSize: 22.0,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  height: 7,
                                                ),
                                                Text(
                                                  "15",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 22.0,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                )
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                              child: Column(
                                            children: [
                                              Text(
                                                "Jobs",
                                                style: TextStyle(
                                                    color: Colors.blueAccent,
                                                    fontSize: 22.0,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(
                                                height: 7,
                                              ),
                                              Text(
                                                "1",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 22.0,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              )
                                            ],
                                          ))
                                        ],
                                      ))),
                              SizedBox(
                                  height:
                                      (constrains.maxWidth < 700) ? 50 : 150),
                              Container(
                                margin: (constrains.maxWidth < 700)
                                    ? EdgeInsets.only(right: 5, left: 5)
                                    : EdgeInsets.only(right: 500, left: 500),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {},
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          80.0)),
                                            ),
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
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ))),
                                      ElevatedButton(
                                          onPressed: () {},
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(80.0),
                                          ))),
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
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              )))
                                    ]),
                              ),
                              SizedBox(
                                  height:
                                      (constrains.maxWidth < 700) ? 10 : 30),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                        onPressed: doUserLogout,
                                        style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(80.0),
                                        ))),
                                        child: Container(
                                            constraints: BoxConstraints(
                                              maxWidth: 150.0,
                                              maxHeight: 40.0,
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Logout",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w300),
                                            )))
                                  ]),
                            ],
                          ));
                    }
                }
              });
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
