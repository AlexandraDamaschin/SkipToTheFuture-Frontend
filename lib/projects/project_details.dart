import 'package:flutter/material.dart';
import 'package:skip_to_the_future_app/projects/project_model.dart';
import 'package:skip_to_the_future_app/translations/localizations.dart';
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
            'subject=${AppLocalizations.of(context).translate('want_to_participate_in_project')} ${project.title}');

    void launchURL() async => await canLaunch(_emailLaunchUri.toString())
        ? await launch(_emailLaunchUri.toString())
        : throw '${AppLocalizations.of(context).translate('unable_to_access_email')}: $_emailLaunchUri.toString()';

    final topContentText = LayoutBuilder(builder: (context, constrains) {
      return SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Image.network(
              project.imageUrl,
              width: (constrains.maxWidth < 700) ? 300 : 900,
              fit: BoxFit.cover,
            ),
          ]),
          SizedBox(height: 5),
          Center(
            child: Text(
              project.title,
              style: TextStyle(color: Colors.white, fontSize: 25.0),
            ),
          ),
          SizedBox(height: 5.0),
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
    });

    final topContent = Stack(children: <Widget>[
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
          ))
    ]);

    final bottomContentText = LayoutBuilder(builder: (context, constrains) {
      return Center(
          child: Text(
        project.content,
        style: TextStyle(fontSize: (constrains.maxWidth < 700) ? 14 : 20),
      ));
    });

    final readButton = LayoutBuilder(builder: (context, constrains) {
      return Container(
          padding: EdgeInsets.symmetric(
              vertical: (constrains.maxWidth < 700) ? 16 : 24),
          margin: (constrains.maxWidth < 700)
              ? EdgeInsets.only(right: 20, left: 20)
              : EdgeInsets.only(right: 500, left: 500),
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: launchURL,
            style: ElevatedButton.styleFrom(
              primary: Color.fromRGBO(58, 66, 86, 1.0),
            ),
            child: Text(
                AppLocalizations.of(context).translate('attent_project'),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: (constrains.maxWidth < 700) ? 16 : 24)),
          ));
    });

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
