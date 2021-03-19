import 'package:bon_enlevement/metier/Enlevemntdata.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Expedition.dart';

//cette ecran est utiliser pour que l'utilisateur saisisse les information relative à l'enlevement
class Enlevement extends StatefulWidget {
  EnlevementData _enlev;
  //le constructeur est munis d'un EnlevementData optionelle, celuis ci est null lorsque l'ecran e appele pour une nouvelle expedition
  // puis il a des valeur lorsque l'utilisateur revient sur cette ecran afin de modifier des information
  Enlevement({Key key, EnlevementData enlev = null }) : super(key: key){
    this._enlev = enlev;
  }

  @override
  _Enlevement createState() => _Enlevement();
}


class _Enlevement extends State<Enlevement> {
  final _dateJour = new DateTime.now();
  TextEditingController _controllerDate = new TextEditingController();
  TextEditingController _controllerViti = new TextEditingController();
  TextEditingController _controllerPresent = new TextEditingController();
  TextEditingController _controllerImmatriculation = new TextEditingController();
  TextEditingController _controllerDestination = new TextEditingController();
  List<String> data = new List<String>();

  void getExpe() async{
    await Navigator.push(
        context, new MaterialPageRoute(builder: (BuildContext context) {
      return Expedition(widget._enlev);
    }));
  }

  //l'initState a pour but de prèRemplir des case lorsque l'utilisateur arrive sur cet ecran
  //les Textfield sont remplis par la date du jour pour la date, le nom Camp Romain pour le viticulteur, et d'un oui pour la presence du viticulteur et un Nouvelle enlevementData est créer
  //si l'utilisateur revien sur l'ecran pour mofifier des information les cases se remplissent des information qu'il a saisie precedement
  initState(){
    if(widget._enlev != null){
      _controllerDate.text = widget._enlev.getDate();
      _controllerViti.text = widget._enlev.getViticulteur();
      _controllerPresent.text = widget._enlev.getVitiPresent();
      _controllerDestination.text =widget._enlev.getDestination() ;
      _controllerImmatriculation.text = widget._enlev.getImmatriculation();
    }
    else{
      widget._enlev = new EnlevementData();
      _controllerDate.text = DateFormat('dd/MM/yyyy').format(_dateJour);
      _controllerViti.text = 'Camp Romain';
      _controllerPresent.text = 'Oui';
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enlèvement'),
      ),
      body: Center(
        child:
        Column(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                child : TextField(

                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    labelText: 'Date',
                  ),
                  controller: _controllerDate,
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child : TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    labelText: 'Viticulteur',
                  ),
                  controller: _controllerViti,
                  keyboardType: TextInputType.text,
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child : TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    labelText: 'Viticulteur Présent',
                  ),
                  controller: _controllerPresent,
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child : TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    labelText: 'Immatriculation',
                  ),
                  controller: _controllerImmatriculation,
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child : TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                    labelText: 'Destination',
                  ),
                  controller: _controllerDestination,
                ),
              ),
              RaisedButton(onPressed: (){
                Navigator.of(context).pop();
              },
              child : Text('annuler'),
              ),
              RaisedButton(onPressed: () {
                //lorsque l'utilisateur passe a l'ecran suivant les donnée saisie sont atribuer au atribut de la classe enlevementData
                // puis cet instance est envoyer a l'ecran Suivant
                //afin de les garder en memoire pour enfin les ecrire dans le fichier pdf
                widget._enlev.setDate(_controllerDate.text);
                widget._enlev.setViti(_controllerViti.text);
                widget._enlev.setPresent(_controllerPresent.text);
                widget._enlev.setImma(_controllerImmatriculation.text);
                widget._enlev.setDest(_controllerDestination.text);
                Navigator.pop(context);
                getExpe();
              },
                child: Text('Suivant'),
              ),
            ]
        ),
      ),
    );
  }
}
