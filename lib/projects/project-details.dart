import 'package:flutter/material.dart';
import 'package:skip_to_the_future_app/projects/project-model.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatelessWidget {
  final Project project;
  DetailPage({Key key, this.project}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final levelIndicator = Container(
      child: Container(
        child: LinearProgressIndicator(
            backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
            value: project.indicatorValue,
            valueColor: AlwaysStoppedAnimation(Colors.green)),
      ),
    );

    final Uri _emailLaunchUri = Uri(
        scheme: 'mailto',
        path: '${project.contact}',
        query:
            'subject=Vreau sa particip in cadrul programului ${project.title}');

    void launchURL() async => await canLaunch(_emailLaunchUri.toString())
        ? await launch(_emailLaunchUri.toString())
        : throw 'Could not launch $_emailLaunchUri.toString()';

    final topContentText = SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Image.network(
            project.imageUrl,
            width: 300,
            fit: BoxFit.cover,
          ),
        ]),
        SizedBox(height: 5.0),
        Text(
          project.title,
          style: TextStyle(color: Colors.white, fontSize: 25.0),
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 1, child: levelIndicator),
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      project.description,
                      style: TextStyle(color: Colors.white),
                    ))),
          ],
        ),
        SizedBox(height: 5.0),
        Text(
          project.hostedBy.toString(),
          style: TextStyle(color: Colors.white),
        ),
      ],
    ));

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            width: 20,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage(project.imageUrl),
                fit: BoxFit.cover,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    final bottomContentText = Text(
      project.content,
      style: TextStyle(fontSize: 14.0),
    );
    final readButton = Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: launchURL,
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child: Text("Participa la acest proiect",
              style: TextStyle(color: Colors.white)),
        ));
    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText, readButton],
        ),
      ),
    );

    return Scaffold(
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }
}
