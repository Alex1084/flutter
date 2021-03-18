import 'package:xml/xml.dart';
import '../metier/GuideAlcoo.dart';


// cette classe est utiliser pour transformer une Chaine de caractere placez dans le connstructeur
// et transforme une balise <unLigne> en un objet GuideAlcoo
// puis ces objet stocke dans une list
class DocXml {
   XmlDocument _doc;
   //cette list represante la totaliter des donnee stoker dans le fichier excel chaque index de la liste
   // possede une temperature ainsi qu'une map contenant dix enfoncement Lu(allant de X,0 a X,9) avec leur dix enfoncement reel
   //cette list est assez importante (car elle contient 672 element GuideAlcoo) alors qu'une seul instance DocXml n'est creer pour limiter de creer trop d'objet
   List<GuideAlcoo> _listFeuilleB;

   //le path est le text/contenue du fichier Xml FeuilleBlanche.xml placer dans assets/data/
   DocXml(String path){
    _doc  = XmlDocument.parse(path);
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
       _listFeuilleB.add(uneligne);
     });
   }

   List<GuideAlcoo> get listFeuilleB => _listFeuilleB;

   //}
}
