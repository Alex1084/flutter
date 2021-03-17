class GuideAlcoo{
  double temperature;
  //ces deux variable ci dessus sont la premiere l'adresse du dreger rectifier recherche
  double coef;
  Map<double,double> degreRectifie;  //cette Map contient en les degre Mesure et en valeur les degre rectifier compris dans la range

  GuideAlcoo(double unetemperature, double unCoef){
    this.temperature = unetemperature;
    this.coef = unCoef;
    degreRectifie = new Map<double, double>();
  }

  void ajoutDegreRec(double unDegreMesure, double unDegreRectifier){
    this.degreRectifie[unDegreMesure] = unDegreRectifier;
  }

  double getTemperature(){
    return this.temperature;
  }
  double getCoef(){
    return this.coef;
  }
  String allDegreString(){
      String allValues = '';
      this.degreRectifie.forEach((key, value) {
        allValues = ('$allValues + $key + $value \n');
      });
      return allValues ;
    }
 @override
  String toString() {
    // TODO: implement toString
    return '${this.getTemperature()} ${this.getCoef()} ${this.allDegreString()}';
  }

  void setTemperature(uneTemperature){
    this.temperature;
  }
  void setCoef(UnCoef){
    this.coef;
  }
}