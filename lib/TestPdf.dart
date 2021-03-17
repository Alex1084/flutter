import 'dart:io';
import 'package:bon_enlevement/Enlevemntdata.dart';
import 'package:bon_enlevement/PdfView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:printing/printing.dart';

import 'Enlevement.dart';
//import 'package:intl/';

class GenerPdf{
  EnlevementData dataEnlevement;

  GenerPdf({EnlevementData lesData}) {
    dataEnlevement = lesData;
  }

  /*@override
  _GenerPdf createState() => _GenerPdf();
}

  class _GenerPdf extends State<GenerPdf>{*/
  static pw.Document pdf = new pw.Document();

  static writeOnPdf(EnlevementData enlevement){
    pdf = new pw.Document();
    pdf.addPage(
      pw.MultiPage(

        pageFormat : PdfPageFormat.a4,
        margin : pw.EdgeInsets.all(54),
        build : (pw.Context context){
          return <pw.Widget>[
            pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children : [
                  pw.Row(
                    children : <pw.Widget>[
                      pw.Container(
                        height : 183,
                        width: 243,
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all( width: 1,),
                        ),
                        child:  pw.Text('Image du camp Romain', style : pw.TextStyle(fontSize: 16,),),
                      ),
                      pw.Container(
                        height: 183,
                        width:  182,
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all( width: 1,),
                        ),
                        child: pw.Text('Enlèvement d\'Eau \n De Vie à la Propriété'),
                      ),
                ],
              ),
                  RowPdf('Date', '${enlevement.getDate()}'),
                  RowPdf('Viticulteur', '${enlevement.getViticulteur()}'),
                  RowPdf('Viticulteur Présent', '${enlevement.getVitiPresent()}'),
                  RowPdf('Immatriculation du Camion', '${enlevement.getImmatriculation()}'),
                  RowPdf('Destination', '${enlevement.getDestination()}'),
                  RowPdf('Volume HLAP à Charger', '${enlevement.getVolumeApACharger()}', margin : 27, unit : true, uniter: 'HLAP',),
                  RowPdf('Température EDV', '${enlevement.getTemperature()}', unit : true, uniter: '°C'),
                  RowPdf('Degré EDV', '${enlevement.getDegre()}', unit : true, uniter: '°'),
                  RowPdf('Degré rectifié', '${enlevement.getDegreReel()}', unit : true, uniter: '°'),
                  RowPdf('Coefficient', '${enlevement.getCoeficient()}', unit : true, ),
                  RowPdf('Volume Brut', '${enlevement.getVolumeBrut()}', unit : true, uniter: 'HL VOL'),
                  RowPdf('Volume Camion à Charger', '${enlevement.getVolumeACharger()}', unit : true, uniter: 'HL VOL'),
                  RowPdf('Volume Arrondi chargé', '${enlevement.getVolumeArrondiCharge()}', unit : true, uniter: 'HL VOL'),
                  RowPdf('Volume Brut Chargé', '${enlevement.getVolumeRectifier()}', unit : true, uniter: 'HL VOL'),
                  RowPdf('HL AP CHARGE', '${enlevement.getVolumeApCharge()}', unit : true, uniter: 'HL '),

                ],
            )
    ];
      }
      )
    );
  }

  static pw.Widget RowPdf(String nom,String donnee, {double margin = 0.00, bool unit = false, String uniter = '', PdfColor colors = PdfColors.white}){
    return pw.Row(
        children: [
          pw.Container(
            //color: colors,
            margin: pw.EdgeInsets.only(top: margin),
            height : 27,
            width: 243,
            decoration: pw.BoxDecoration(
              border: pw.Border.all( width: 1,),
            ),
            child: pw.Text('$nom', style : pw.TextStyle(fontSize: 16,), textAlign: pw.TextAlign.center),
          ),
          pw.Container(
            //color : colors,
            margin: pw.EdgeInsets.only(top: margin),
            height : 27,
            width: 182,
            decoration: pw.BoxDecoration(
              border: pw.Border.all( width: 1,),
            ),
            child: pw.Text('$donnee', style : pw.TextStyle(fontSize: 16,),  textAlign: pw.TextAlign.right),
          ),
          (unit == false ?  pw.Container() : pw.Container(
            //color: colors,
            margin: pw.EdgeInsets.only(top: margin),
            height : 27,
            width: 61,
            decoration: pw.BoxDecoration(
              border: pw.Border.all( width: 1,),
            ),
            child: pw.Text('$uniter', style : pw.TextStyle(fontSize: 16,),),
          )
          ),

        ]);
  }

  Future savePdf() async{
    Directory document = await getApplicationDocumentsDirectory();
    String documentPath =  document.path;
    File file = File('$documentPath/exemple.pdf');
    file.writeAsBytesSync(await pdf.save());
    //file.writeAsBytesSync(pdf.save());
  }

  Future<String> getPath() async{
    Directory document;
    document = await getApplicationDocumentsDirectory();
    String documentPath =  document.path;

    return documentPath;
  }

  static Future<void> impresion() async{
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }
 /* Widget build(BuildContext context){
    //_volumeArrondi = widget.dataEnlevement.volArr.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text('PDF generator'),
      ),

      body: Center(
        child : Column(
         children: [
           Container(
             child:Column(children : [
               RaisedButton(onPressed: (){
                 print(widget.dataEnlevement.getDegreReel());
                 print(PdfPageFormat.a4.height);
               }),
               /*RaisedButton(
                   onPressed:()async{
                     print(new DateFormat.yMd().format(new DateTime.now()));
                     print(await getPath());
                     //print(Enlevement._test);
                   }
               ),
               RaisedButton(
                 onPressed : (){
                   impresion();},
                 child : Text('impresion'),
               ),

               RaisedButton(
                 onPressed : (){
                   print(widget.dataEnlevement.volArr);
                   },
                 child : Text('print'),
               ),*/
               /*Text('${new DateTime.now()}',
                   style: TextStyle(fontSize: 24)
               ),
               Text('${widget.dataEnlevement.getViti()}',
                   style: TextStyle(fontSize: 24)
               ),
               Text('${widget.dataEnlevement.getImma()}',
                   style: TextStyle(fontSize: 24)
               ),
               Text('${widget.dataEnlevement.getDest()}',
                   style: TextStyle(fontSize: 24)
               ),
               Text('${widget.dataEnlevement.volHalpAChar}',
                   style: TextStyle(fontSize: 24)
               ),
               Text('${widget.dataEnlevement.temp}',
                   style: TextStyle(fontSize: 24)
               ),
               Text('${widget.dataEnlevement.degM}',
                   style: TextStyle(fontSize: 24)
               ),
               Text('${widget.dataEnlevement.degR}',
                   style: TextStyle(fontSize: 24)
               ),
               Text('${widget.dataEnlevement.coef}',
                   style: TextStyle(fontSize: 24)
               ),
               Text('${widget.dataEnlevement.volBrut}',
                   style: TextStyle(fontSize: 24)
               ),
               Text('${widget.dataEnlevement.volAChar}',
                   style: TextStyle(fontSize: 24)
               ),
               Text('${widget.dataEnlevement.volArr}',
                   style: TextStyle(fontSize: 24)
               ),
               TextField(
                 controller: _leVolArr,
               ),
               RaisedButton(onPressed: (){
                 widget.dataEnlevement.setArrondi(double.parse(_leVolArr.text));
                 setState(() {

                 });
               }),
               Text('${widget.dataEnlevement.volRectif}',
                   style: TextStyle(fontSize: 24)
               ),
               Text('${widget.dataEnlevement.volHalpChar}',
                   style: TextStyle(fontSize: 24)
               ),*/
               RaisedButton(onPressed: (){writeOnPdf(widget.dataEnlevement);impresion();}, child: Text('imp'),)
             ]
             ),
           ),
         ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          //writeOnPdf(widget.dataEnlevement);
          await savePdf();

          Directory document = await getApplicationDocumentsDirectory();
          String documentPath =  document.path;
          String fullPath = '$documentPath/exemple.pdf';
          print(documentPath);

          Navigator.push(context , MaterialPageRoute(builder: (context) => View(path: fullPath,)
          ));
        },
      ),
    );
  }*/
}