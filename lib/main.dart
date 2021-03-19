import 'package:flutter/material.dart';
import 'ihm/Enlevement.dart';
import 'ihm/ReconnNiv.dart';

//voici les principaux package extern utiliser pour le developpement
// peu utiliser dans cette application mais la package Path_provider perment d'enregistrer toute sorte de document
// https://pub.dev/packages/path_provider/install

// le package xml permet de au d'interpreter un fichier pour n'en sortir que les valeur
// https://pub.dev/packages/xml

// le package pdf permet de creer et d'editer un fichier pdf
// https://pub.dev/packages/pdf

//le package printing permet d'imprimer on de telecharger un pdf ou une page web
// https://pub.dev/packages/printing
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

//l'ecran d'accuile permet de choisir l'ecrans sur le quelle on veut aller,
//meme si l'ecran pour la reconnaissance de niveau n'est pas finis j'ai choisis de laisser l'acced a l'utilisateur
class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    void getEnlevement() async{
      await Navigator.push(
          context, new MaterialPageRoute(builder: (BuildContext context) {
        return Enlevement();
      }));
    }
    void getreconLvl() async{
      await Navigator.push(
          context, new MaterialPageRoute(builder: (BuildContext context) {
        return ReconnNiv();
      }));
    }

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(onPressed: getEnlevement,

            child :Text('Bon d\'enlèvement'
              ),
            ),
            RaisedButton(onPressed: getreconLvl,
            child : Text('reconnaissance de niveau'))
          ],
        ),
      ),
    );
  }
}
