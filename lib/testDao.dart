import 'package:xml/xml.dart';
import 'dart:io';
import 'GuideAlcoo.dart';



class DocXml {
  //List<GuideAlcoo> feuilleB = new List();
   XmlDocument _doc;
   List<GuideAlcoo> _listFeuilleB;
  //final FileUtils storage;
  //doc = XmlDocument.parse(widget.storage)
  DocXml(String Path){
    _doc  = XmlDocument.parse(Path);
    _listFeuilleB = new List<GuideAlcoo>();

  }

   void generationFeuilleBlanche(){
     double degMes, degRect, coef, temp;
     final titles = _doc.findAllElements('uneLigne');
     titles.forEach((element) {
       temp = double.parse(element.findElements('Temperature').first.text);
       coef = double.parse(element.findElements('Coeficient').first.text);


       GuideAlcoo uneligne = new GuideAlcoo(temp, coef);

       for(var i = 0; i <= 9; i++){
         final cle = element.findAllElements('Cle$i');
         //print(cle);
         cle.forEach((element) {
           degMes = double.parse(element.findElements('DegreMesure').first.text);
           degRect = double.parse(element.findElements('DegreRectifier').first.text);
           uneligne.ajoutDegreRec(degMes, degRect);
         });
       }
       //print('${uneligne.getTemperature()} ${uneligne.getCoef()} ${uneligne.getRangeDegre()}');
       _listFeuilleB.add(uneligne);
     });
   }

   List<GuideAlcoo> get listFeuilleB => _listFeuilleB;

//XmlDocument get doc => _doc;
   //}
}
