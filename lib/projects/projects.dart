import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:skip_to_the_future_app/projects/project-details.dart';
import 'package:skip_to_the_future_app/projects/project-model.dart';
import 'package:skip_to_the_future_app/user/user_info.dart';

class ProjectsPage extends StatefulWidget {
  ProjectsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  String localImage = "assets/images/1.jpg";

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(Project project) => ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: new BoxDecoration(
                  border: new Border(
                      right:
                          new BorderSide(width: 1.0, color: Colors.white24))),
              child: Image.network(project.imageUrl)),
          title: Text(
            project.title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                    child: LinearProgressIndicator(
                        backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
                        value: project.indicatorValue,
                        valueColor: AlwaysStoppedAnimation(Colors.green)),
                  )),
              Expanded(
                flex: 4,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(project.description,
                        style: TextStyle(color: Colors.white))),
              )
            ],
          ),
          trailing:
              Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailPage(project: project)));
          },
        );

    Card makeCard(Project project) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: makeListTile(project),
          ),
        );

    final makeBody = FutureBuilder<List<ParseObject>>(
        future: getProjects(),
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
                  child: Text("Error..."),
                );
              } else {
                return Container(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return makeCard(Project(
                        title: snapshot.data[index].get<String>('title'),
                        content:
                            snapshot.data[index].get<String>('description'),
                        description: snapshot.data[index].get<String>('skills'),
                        indicatorValue: 3,
                        hostedBy: snapshot.data[index].get<String>('hostedBy'),
                        location: snapshot.data[index].get<String>('location'),
                        url: snapshot.data[index].get<String>('url'),
                        imageUrl: snapshot.data[index].get<String>('imageUrl'),
                        contact: snapshot.data[index].get<String>('contact'),
                      ));
                    },
                  ),
                );
              }
          }
        });

    final makeBottom = Container(
      height: 55.0,
      child: BottomAppBar(
        color: Color.fromRGBO(58, 66, 86, 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.account_box, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserInfoPage()),
                );
              },
            )
          ],
        ),
      ),
    );
    final topAppBar = AppBar(
        elevation: 0.1,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        title: Text("Projects"));

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topAppBar,
      body: makeBody,
      bottomNavigationBar: makeBottom,
    );
  }
}

Future<List<ParseObject>> getProjects() async {
  QueryBuilder<ParseObject> query =
      QueryBuilder<ParseObject>(ParseObject('Project'));
  final ParseResponse apiResponse = await query.query();

  if (apiResponse.success && apiResponse.results != null) {
    return apiResponse.results;
  } else {
    return [];
  }
}
