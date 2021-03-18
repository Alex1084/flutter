import 'package:bon_enlevement/Xml/DaoEpallement.dart';
import 'package:bon_enlevement/Xml/DaoGuideAlcoo.dart';
import 'package:flutter/material.dart';


//cette ecran n'a pas pue etre finis par manque de temps
//il doit permetre de reconnaitre le volume d'alcool en fonction de la auteur lue sur a jauge d'appalement
//après cela en saisissant l'enfoncement et la temperature l'aplication doit renvoyer l'enfoncement Reel et le voulume en alcool pur pour etre sauvegarder par les suite
class ReconnNiv extends StatefulWidget{

  @override
  _ReconnNiv createState() => _ReconnNiv();
}

class _ReconnNiv extends State<ReconnNiv>{
  TextEditingController _hauteurRechercher, _temperature, _enfoncement;
  String dropdownValue = '10';
  String test;
  DaoEpallement cuve;
  double leVolume;
  int selectRadio;
  DocXml data;
  rechercheFichier(String value){
    return 'assets/data/eppalement/$value.xml';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _hauteurRechercher = new TextEditingController();
    _temperature = new TextEditingController();
    _enfoncement = new TextEditingController();
    selectRadio = 0;
    initDoc();

  }

  void initDoc()async {
    test = await DefaultAssetBundle.of(context).loadString(rechercheFichier('10'));
    cuve = new DaoEpallement(test);
    cuve.generationDonne();
  }
  void setSelectRadio(int value){
    setState(() {
      this.selectRadio = value;
    });
  }

  @override
  build(BuildContext context){
    //hauteurRechercher.text = '0.00';
    return Scaffold(
      body : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //les bouton Radio devait pour etre un choix pour l'utilisateur et lui permetre de lire l'nefoncement reel avec les Page Jaune
                //ou les page Blanche
                Container(
                  child: Row(
                    children :[
                      Radio(value: 1,
                          groupValue: selectRadio,
                          onChanged: (value){
                            setSelectRadio(value);
                          }),
                      Text('Pages Jaune'),
                  ],),
                ),
                Container(
                  child: Row(
                    children :[
                      Radio(value: 2,
                          groupValue: selectRadio,
                          onChanged: (value){
                            setSelectRadio(value);
                          }),
                      Text('Pages Blanche'),
                  ],
                  ),
                ),
              ],
            ),
            DropdownButton(
              //le drop down Button est utiliser pour choisir la cuve que
              // l'on veux mesure chaque cuve a un fichier different alors l'item dois avoir le meme nom que le fochier
                value: dropdownValue,

                items: <String>['10', '11', '12', '13', '14E', '24_chais', '25_chais', '30', '30BC', 'E1', 'E2']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String newValue) async{
                  setState(() {
                    dropdownValue = newValue;
                  });
                  test = await DefaultAssetBundle.of(context).loadString(rechercheFichier(dropdownValue));
                  cuve = new DaoEpallement(test);
                  cuve.generationDonne();
                  //print(test);
            }
            ),
            TextField(
              controller: _hauteurRechercher,
              decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(100),),
                labelText: 'Hauteur Mesuré',
              ),
            ),
            TextField(
              controller: _temperature,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(100),),
                labelText: 'Temperature Mesuré',
              ),
            ),
            TextField(
              controller: _enfoncement,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(100),),
                labelText: 'Enfoncement lu',
              ),
            ),

            RaisedButton(onPressed: (){
             setState(() {
               leVolume = cuve.rechercheVolume(_hauteurRechercher.text);
             });
             //print(cuve.mapToString());
            }),

            RaisedButton(onPressed: () {
              initState();
            },
            child: Text('Nouvelle Pese'),),
            Text('$leVolume'),
          ],
        ),
      ),
    );
  }
}