import 'package:bon_enlevement/Enlevement.dart';
import 'package:bon_enlevement/Enlevemntdata.dart';
import 'package:bon_enlevement/TestPdf.dart';
import 'package:bon_enlevement/testDao.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Expedition extends StatefulWidget {
  EnlevementData  _lesdataCalcul ;
  Expedition(EnlevementData enlev){
    this._lesdataCalcul = enlev;
  }
  @override
  _Expedition createState() => _Expedition();
}

class _Expedition extends State<Expedition> {
  List<String> data = List<String>.empty();
  TextEditingController _temperature, _degre, _volumeAP;
  double _coeficient, _degreRectif, _volAchar;
  String test;
  DocXml leDoc;
  TextEditingController _controllerVolArr;
  bool _verifVolArr , _verifTemp, _verifDegre, _verifVolAp;

  void getEnlev() async{
    await Navigator.push(
        context, new MaterialPageRoute(builder: (BuildContext context) {
      return Enlevement(enlev: widget._lesdataCalcul,);//(lesInfos: data,);
    }));
  }
  void getPdf() async{

      widget._lesdataCalcul.setArrondi(controlSai(_controllerVolArr.text));
      GenerPdf.writeOnPdf(widget._lesdataCalcul);
      GenerPdf.impresion();
      /*await Navigator.push(
          context, new MaterialPageRoute(builder: (BuildContext context)
      {
        return GenerPdf(lesData: this._lesdataCalcul,);
      }));*/
  }

  readFeuilleBlanche() async{
    test = await DefaultAssetBundle.of(context).loadString('assets/data/FeuilleBlanche.xml');
    leDoc = new DocXml(test);
    leDoc.generationFeuilleBlanche();
  }
  double controlSai(String uneMesure){
    String mesureRetourner;
    if(double.tryParse(uneMesure) == null) {
      int virgule = uneMesure.indexOf(',');
      if (virgule != -1) {
        String uniter = uneMesure.substring(0, virgule);
        String dixieme = uneMesure.substring(virgule + 1, uneMesure.length);
        mesureRetourner = '$uniter.$dixieme';
      }
      else {
        //snack;
        mesureRetourner= '#';
      }
    }
    else{
      mesureRetourner = uneMesure;
    }
    return double.parse(mesureRetourner);

  }
  @override
  initState() {
    super.initState();
    readFeuilleBlanche();
    _controllerVolArr = new TextEditingController();
    _temperature = new TextEditingController();
    _volumeAP = new TextEditingController();
    _degre = new TextEditingController();
    if(widget._lesdataCalcul.getVolumeApACharger() != 0.00){
      _controllerVolArr.text = widget._lesdataCalcul.getVolumeArrondiCharge().toString();
      _temperature.text = widget._lesdataCalcul.getTemperature().toString();
      _volumeAP.text = widget._lesdataCalcul.getVolumeApACharger().toString();
      _degre.text = widget._lesdataCalcul.getDegre().toString();
      _coeficient= widget._lesdataCalcul.getCoeficient();
      _degreRectif= widget._lesdataCalcul.getDegreReel();
      _volAchar = widget._lesdataCalcul.getVolumeRectifier();
    }
    else{
      _coeficient= 0.00;
      _degreRectif= 0.00;
      _volAchar = 0.00;

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Enlevement'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment : CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              margin: EdgeInsets.only(bottom: MediaQuery
                  .of(context)
                  .size
                  .width / 32, top: MediaQuery
                  .of(context)
                  .size
                  .width / 8, right: 0, left: 0),
              child: TextField(

                  keyboardType: TextInputType.text,
                  controller: _volumeAP,
                  onChanged: (String unVolumeACharger) {
                    try{
                      setState(() {
                        _verifVolAp = false;
                      });
                    }
                    catch(e){
                      setState(() {
                        _verifVolAp = true;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Volume AP a charger',
                    errorText: (_verifVolAp == true ? 'erreur de saisie' : null),
                    filled : true,
                    fillColor: Colors.blue[200],
                  ),
                style: TextStyle(
                  height: 1,
                ),
                ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: TextField(
                    controller: _temperature,
                    keyboardType: TextInputType.text,
                    onChanged: (String uneTemperature) {
                      try{
                        setState(() {
                          controlSai(uneTemperature);
                          _verifTemp = false;
                        });
                      }
                      catch(e){
                        setState(() {
                          _verifTemp = true;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      errorText: (_verifTemp == true ? 'erreur de saisie' : null),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Temperature',
                      filled : true,
                      fillColor: Colors.blue[200],
                    ),
                  ),
                  ),
                  Flexible(
                    flex: 1,child: TextField(
                    controller: _degre,
                    keyboardType: TextInputType.text,
                    onChanged: (String unDegre) {
                      try{
                        setState(() {
                          controlSai(unDegre);
                          _verifDegre = false;
                        });
                      }
                      catch(e){
                        setState(() {
                          _verifDegre = true;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'enfoncement',
                      errorText: (_verifDegre == true ? 'erreur de saisie' : null),
                      filled : true,
                      fillColor: Colors.blue[200],
                    ),
                  ),
                  ),
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                    onPressed: () {
                  setState(() {
                    //_lesdataCalcul =  new EnlevementData(_temperature, _degre,_volumeAP, leDoc.listFeuilleB);

                    widget._lesdataCalcul.doCalcul(temp: controlSai(_temperature.text), degre: controlSai(_degre.text), volAp: controlSai(_volumeAP.text), unGuide: leDoc.listFeuilleB);
                    _coeficient = widget._lesdataCalcul.getCoeficient();
                    _degreRectif = widget._lesdataCalcul.getDegreReel();
                    _volAchar = widget._lesdataCalcul.getVolumeACharger();
                    _verifVolArr = true;
                  });
                },
                child : Text('calculer',)
                ),
              ],
            ),
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              margin: EdgeInsets.only(bottom: 0, top: MediaQuery
                  .of(context)
                  .size
                  .width / 8, right: 0, left: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height:50,
                    width:  MediaQuery.of(context).size.width/2.5,
                    margin: EdgeInsets.only(left : MediaQuery.of(context).size.width / 16 ),
                    child : Text('Enfoncement Reèl : ${_degreRectif}',
                      style: TextStyle(fontSize: 18,),
                      textAlign: TextAlign.center,
                    ),
                    decoration : BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1,),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.yellow[200]
                    ),
                  ),
                  Container(
                    height:50,
                    width:  MediaQuery.of(context).size.width/2.5,
                    margin: EdgeInsets.only(right : MediaQuery.of(context).size.width / 16),
                    child : Text('Coeficient :\n ${_coeficient}',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    decoration : BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1,),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.yellow[200]
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height:50,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              margin: EdgeInsets.only(bottom: 0, top: MediaQuery
                  .of(context)
                  .size
                  .width / 8, right: 0, left: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                      Container(
                          width:  MediaQuery.of(context).size.width/2.5,
                          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/16, right: MediaQuery.of(context).size.width/16),
                        child : Text('Volume Camion à Charger : ${_volAchar}',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                        ),
                          decoration : BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1,),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.yellow[200]
                          ),
                        ),
                  Flexible(

                    child:TextField(

                    keyboardType: TextInputType.number,
                    controller: _controllerVolArr,
                    onChanged: (String string){
                      try{

                        setState(() {
                          widget._lesdataCalcul.setArrondi(controlSai(_controllerVolArr.text));
                          _verifVolArr = false;
                        });
                      }
                      catch(e){
                        setState(() {
                          _verifVolArr = true;
                        });
                      }

                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(

                      borderRadius: BorderRadius.circular(10)),
                      labelText: 'Volume Arrondi',
                      errorText : (_verifVolArr == true ? 'erreur de Saisie' : null),
                      filled : true,
                      fillColor: Colors.blue[200],
                    ),
                  ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height:70,
                  width:  MediaQuery.of(context).size.width/2.5,
                  margin: EdgeInsets.only( top: MediaQuery
                      .of(context)
                      .size
                      .width / 8,),
                  child: Text('Volume AP chargè : \n${widget._lesdataCalcul.getVolumeApCharge()}',
                      style : TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,),
                  decoration : BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1,),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.yellow[200]
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(

                  margin: EdgeInsets.only( top: MediaQuery
                      .of(context)
                      .size
                      .width / 32,),
                  child: RaisedButton(onPressed: (){
                    _verifVolArr = false;
                      getPdf();
                    //Navigator.pop(context);


                    },
                    child: Text('Enregistrer / imprimer en pdf'),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only( top: MediaQuery
                      .of(context)
                      .size
                      .width / 16, right: 0,),
                  child: RaisedButton(onPressed: (){
                    Navigator.of(context).pop();
                  },
                    child: Text('Annuler'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 0, top: MediaQuery
                      .of(context)
                      .size
                      .width / 16, right: 0,
                    left: MediaQuery
                        .of(context)
                        .size
                        .width / 16,),
                  child: RaisedButton(onPressed: (){
                    Navigator.of(context).pop();
                    getEnlev();
                    setState(() {

                    });


                  },
                    child: Text('Retour'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}