import 'GuideAlcoo.dart';

class EnlevementData{
  String _date;
  String _viticulteur, _immatriculation, _destination, _viticulteurPresent ;
  double _temp, _degM, _degR, _coef;
  double _volBrut, _volAChar, _volArr, _volRectif, _volHalpChar, _volHalpAChar;
  //List<GuideAlcoo> unGuide;
  EnlevementData(){
    this._temp = 0.00;
    this._degM = 0.00;
    this._volHalpAChar = 0.00;
    this._volRectif = 0.00;
    this._degR = 0.00;
    this._coef = 0.00;
    this._volHalpChar = 0.00;
    //this.unGuide = new List.empty();
    //this._degR = rechercheDegre(unGuide, this._degM, this._temp);
    //this._coef = rechercheCoef(unGuide, this._degM, this._temp)/1000;
    this._viticulteur = '';
    this._immatriculation = '';
    this._destination = '';
    this._viticulteurPresent = '';

  }

  void doCalcul(
      {double temp, double degre, double volAp, List<GuideAlcoo> unGuide}){
    this._temp = temp;
    this._degM = degre;
    this._volHalpAChar = volAp;
    this._degR = rechercheDegre(unGuide, this._degM, this._temp);
    this._coef = rechercheCoef(unGuide, this._degM, this._temp)/1000;
    _volBrut = calculVolumeBrut(_volHalpAChar, _degR);
    _volAChar = calculAcharger(_volBrut, _coef);
    _volArr = arrondi(_volAChar);
    _volRectif = recifier(_volArr, _coef);
    _volHalpChar = calculVolAPChar(_volArr, _degR, _coef);

  }



  double rechercheDegre(List<GuideAlcoo> unGuide, double unDegreMesure,double uneTemperature) {
    double degreRectifie = 0;
    int degreRangeMesure;
    bool trouver = false;
    bool finis = false;
    degreRangeMesure = unDegreMesure.toInt();
    int i = 0;
    while(trouver == false && finis == false )
    {
      //print(i);
      if(uneTemperature == unGuide[i].getTemperature() && unGuide[i].degreRectifie.containsKey(degreRangeMesure))
      {
          degreRectifie = unGuide[i].degreRectifie[unDegreMesure];
          trouver = true;
        }
        else
        if (i == unGuide.length-1)
        {
          finis = true;
        }
        else {
          i++;
        };
    }
    if (trouver == true){
      return degreRectifie;
    }
    else if(finis = true){
      return -1;
    }
  }

  double rechercheCoef(List<GuideAlcoo> unGuide, double unDegreMesure,double uneTemperature){
    double coeficient = 0;
    int degreRangeMesure;
    bool trouver = false;
    bool finis = false;
    degreRangeMesure = unDegreMesure.toInt();
    int i = 0;
    while(trouver == false && finis == false )
    {
      //print(i);
      if(uneTemperature == unGuide[i].getTemperature() && unGuide[i].degreRectifie.containsKey(degreRangeMesure))
      {
        coeficient = unGuide[i].getCoef();
        trouver = true;
      }
      else
      if (i == unGuide.length-1)
      {
        finis = true;
      }
      else {
        i++;
      };
    }
    if (trouver == true){
      return coeficient;
    }
    else if(finis = true){
      return -1;
    }
  }
  double calculVolumeBrut(double volHalpAChar,double degR){
    return double.parse((100*(volHalpAChar/degR)).toStringAsFixed(4));
  }
  double calculAcharger(double volBrut, double coef){
    return double.parse((volBrut/coef).toStringAsFixed(4));
  }

  double arrondi(volAChar){
    return double.parse(volAChar.toStringAsFixed(2));
  }

  double recifier(double volArr, double coef){
    return double.parse((volArr * coef).toStringAsFixed(4));
  }

  double calculVolAPChar(double unVolArr, double degR, double coeficient){
    return double.parse((unVolArr * degR* coeficient/100).toStringAsFixed(4));
  }
  //#region les Getteurs
  String getViticulteur(){
    return this._viticulteur;
  }
  String getImmatriculation(){
    return this._immatriculation;
  }
  String getDestination(){
    return this._destination;
  }
  String getDate(){
    return this._date;
  }
  String getVitiPresent(){
    return this._viticulteurPresent;
  }
  double getTemperature(){
    return this._temp;
  }
  double getDegre(){
    return this._degM;
  }
  double getDegreReel(){
    return this._degR;
  }
  double getCoeficient(){
    return this._coef;
  }
  double getVolumeBrut(){
    return this._volBrut;
  }
  double getVolumeApACharger(){
    return this._volHalpAChar;
  }
  double getVolumeACharger(){
    return this._volAChar;
  }
  double getVolumeArrondiCharge(){
    return this._volArr;
  }
  double getVolumeRectifier(){
    return this._volRectif;
  }
  double getVolumeApCharge(){
    return this._volHalpChar;
  }
  //#endregion

  void setArrondi(double value){
    this._volArr = value;
    this._volRectif = recifier(this._volArr, this._coef);
    this._volHalpChar = calculVolAPChar(this._volArr, this._degR, this._coef);
  }
  void setDate(String value){
    this._date = value;
  }
  void setViti(String value){
    this._viticulteur = value;
  }
  void setImma(String value){
    this._immatriculation = value;
  }
  void setPresent(String value){
    this._viticulteurPresent = value;
  }
  void setDest(String value){
    this._destination = value;
  }
}