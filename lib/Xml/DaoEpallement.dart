import 'package:xml/xml.dart';


//cette class a pour but de parcourir le fichier appeler
//cette class est utiliser dans l'ecran reconnNiv donc les fonctinaliter de cette classe n'ont pas pue etre très developpe
class DaoEpallement{
  Map<double, double> _tableEpallement;
  XmlDocument _doc;

  DaoEpallement(String path){
    _doc = XmlDocument.parse(path);
    _tableEpallement = new Map<double, double>();
  }

  void generationDonne(){
    double hauteur, volume;
    final epalemment = _doc.findAllElements('tableEpallement');
    epalemment.forEach((element) {
      final values = element.findAllElements('valeur');
      values.forEach((element) {
        hauteur = double.parse(element.findElements('hauteur').first.text);
        volume = double.parse(element.findElements('volume').first.text);
        ajoutDonnees(hauteur, volume);
      });
    });
  }

  void ajoutDonnees(double uneHauteur, double unVolume){
    _tableEpallement[uneHauteur] = unVolume;
  }

  String mapToString(){
    String laMap = '';
    _tableEpallement.forEach((key, value) {
      laMap = laMap + '$key : $value \n';
    });
    return laMap;
  }

  double rechercheVolume(String uneHauteur){
    double volumeRetour;
    _tableEpallement.forEach((key, value) {
      //print(value);
      if(key == double.parse(uneHauteur)){
        //print(value);
        volumeRetour = value;
      }
    });
    return volumeRetour;
  }
}