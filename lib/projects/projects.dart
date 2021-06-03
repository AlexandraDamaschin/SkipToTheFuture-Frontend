import 'package:flutter/material.dart';
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
  List projects;
  String localImage = "assets/images/1.jpg";

  @override
  void initState() {
    projects = getProjects();
    super.initState();
  }

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

    Card makeCard(Project lesson) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: makeListTile(lesson),
          ),
        );

    final makeBody = Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: projects.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(projects[index]);
        },
      ),
    );

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
      title: Text("Projects"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserInfoPage()),
            );
          },
        )
      ],
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topAppBar,
      body: makeBody,
      bottomNavigationBar: makeBottom,
    );
  }
}

List getProjects() {
  return [
    Project(
        title: "WE HELP ȘCOALA DIN SĂCEL!",
        description: "Team Work, Fundraising",
        indicatorValue: 0.33,
        content:
            "În urma participării la Maratonul Internațional Sibiu 2020 am reușit, cu ajutorul a 67 de alergători și 228 de susținători, să stângem suma de 17511 lei.Am ales să inițiem un proiect pentru Școala din Săcel pentru că fără continuitate un proiect privind educația nu poate evolua. Astfel dezvoltăm demersurile, începute de către noi în 2016, de a susține educația în zona rurală din județul Sibiu, prin modernizarea unor săli de activități în școlile din Țichindeal și Mag.",
        hostedBy: "Asociatia We Help!",
        location: "Sibiu",
        url: "https://we-help.ro/we-help-scoala-din-sacel/",
        imageUrl:
            "https://we-help.ro/wp-content/uploads/2020/08/we-help-scoala-din-sacel.png"),
    Project(
        title: "NE PREGĂTIM PENTRU VIAȚĂ",
        description: "Public speaking, Project management",
        indicatorValue: 0.83,
        content:
            "Proiectul ‘’Ne pregătim pentru viață‘‘ și-a propus ca în decursul a patru zile să le ofere copiilor din cadrul programului nostru educativ ‘‘Ajută copiii din familii defavorizate să meargă la școală ‘‘ oportunități de socializare și suportul material de care ei au nevoie în vederea depășirii problemelor dificile cu care se confruntă și dezvoltării abilităților necesare pentru a-și asigura un trai decent în viitor.",
        hostedBy: "Asociatia We Help!",
        location: "Sibiu",
        url: "https://we-help.ro/ne-pregatim-pentru-viata/",
        imageUrl:
            "https://we-help.ro/wp-content/uploads/2018/03/42461494_1076702682512191_5384800038880804864_n.jpg"),
    Project(
        title: "DORINȚA DE CRĂCIUN",
        description: "Project management, Team Work",
        indicatorValue: 0.13,
        content:
            "Campania “Dorința de Crăciun” a luat naștere din dorința oamenilor de a ajuta chiar și în situația actuală. Deoarece ne doream să organizăm un proiect care să ajute copiii, dar în același timp să ne asigurăm că întreaga noastră echipă este în siguranță am luat decizia de a organiza o strângere de fonduri online. Prin acest proiect am reușit cu ajutorul vostru să pregătim 190 de copii pentru iarnă. ",
        hostedBy: "Asociatia We Help!",
        location: "Sibiu",
        url: "https://we-help.ro/dorinta-de-craciun/",
        imageUrl:
            "https://we-help.ro/wp-content/uploads/2020/11/ShoeBox2019-1024x576.jpg"),
    Project(
        title: "WE HELP ȘCOALA DIN MAG!",
        description: "Team Work",
        indicatorValue: 1,
        content:
            "După mai bine de 3 săptămani de muncă am reușit să deschidem oficial sala noastră de cercetare la Școala din Mag! Datorită vouă celor care ați ales să alergați/susțineți proiectul nostru înscris la Maratonul International Sibiu am renovat două săli din școală. Cei mici s-au bucurat foarte mult când au descoperit că au o sală de documentare științifică și pedagogică. Aici se pot bucura citind o carte, realizând ateliere de creație sau vizionând emisiuni educative.",
        hostedBy: "Asociatia We Help!",
        location: "Sibiu",
        url: "https://we-help.ro/we-help-scoala-din-mag/",
        imageUrl: "https://we-help.ro/wp-content/uploads/2019/04/Mag.png"),
    Project(
        title: "WE HELP BY CODING",
        description: "Fundraising",
        indicatorValue: 0.73,
        content:
            "We Help By Coding este un proiect pentru care aplicăm anual din 2017 până în prezent.Dorim să le împărtășim celor mici din cunoștințele noastre despre tehnologia informației, calculatoare și diferite modalități de a învăța programare sub forma unei provocări amuzante. Copiii au nevoie de o oportunitate să experimenteze și să exploreze lumea tehnologiei pentru a se pregăti de viața într-o societate modernă și pentru a-și dezvolta abilitățile de rezolvare a problemelor.",
        hostedBy: "Asociatia We Help!",
        location: "Sibiu",
        url: "https://we-help.ro/we-help-by-coding/",
        imageUrl:
            "https://we-help.ro/wp-content/uploads/2018/10/1109-Document1.jpeg"),
    Project(
        title: "SHOEBOX",
        description: "Team work, Public speaking",
        indicatorValue: 0.5,
        content:
            "„ShoeBox” este o inițiativă de ajutorare a copiilor din familii cu posibilități materiale reduse, campanie începută în anul 2007 de o familie din Cluj, continuată la nivel de oraș, apoi extinsă în toată țara. Conceptul presupune ca donatorul să ofere unul sau mai multe cadouri cu un volum rezonabil, care să încapă într-o cutie de pantofi, de aici și denumirea de ,,ShoeBox”. ",
        hostedBy: "Asociatia We Help!",
        location: "Sibiu",
        url: "https://we-help.ro/shoebox/",
        imageUrl:
            "https://we-help.ro/wp-content/uploads/2020/02/5b58914d-c196-407d-98f2-428d786548ae-1-1024x576.jpg")
  ];
}
