import 'package:bon_enlevement/Expedition.dart';
import 'package:bon_enlevement/ReconnNiv.dart';
import 'package:bon_enlevement/TestPdf.dart';
import 'package:flutter/material.dart';
import 'package:bon_enlevement/Enlevement.dart';
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

class _MyHomePageState extends State<MyHomePage> {
  List<String>lesInfos= new List<String>.empty();

  @override
  Widget build(BuildContext context) {


    void getEnlevement() async{
      lesInfos = await Navigator.push(
          context, new MaterialPageRoute(builder: (BuildContext context) {
        return Enlevement();
      }));
    }
    void getreconLvl() async{
      lesInfos = await Navigator.push(
          context, new MaterialPageRoute(builder: (BuildContext context) {
        return ReconnNiv();
      }));
    }
    void getPdf() {
      /*Navigator.push(
          context, new MaterialPageRoute(builder: (BuildContext context) {
        return GenerPdf();
      }));*/
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

            child :Text('Bon d\'enlevement'
              ),
            ),
          /*  RaisedButton(onPressed: getExpe,

              child :Text('les expe'
              ),
            ),*/
            /*RaisedButton(onPressed: getPdf,

              child :Text('Essai PDF'
              ),
            ),*/
           /* RaisedButton(onPressed: (){
              print(lesInfos.elementAt(0));
              print(lesInfos.elementAt(1));
              print(lesInfos.elementAt(2));
              print(lesInfos.elementAt(3));
            },

              child :Text('print'
              ),
            ),*/
            RaisedButton(onPressed: getreconLvl)
          ],
        ),
      ),
    );
  }
}
