import 'package:bon_enlevement/Enlevemntdata.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Expedition.dart';

class Enlevement extends StatefulWidget {
  EnlevementData _enlev;
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
      _controllerViti.text = 'CampRomain';
      _controllerPresent.text = 'Oui';
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enlevement'),
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
                    labelText: 'Viticulteur Present',
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
