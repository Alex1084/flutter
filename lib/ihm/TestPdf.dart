import 'dart:io';
import 'package:bon_enlevement/metier/Enlevemntdata.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';

class GenerPdf {
  EnlevementData dataEnlevement;

  GenerPdf({EnlevementData lesData}) {
    dataEnlevement = lesData;
  }

  /*@override
  _GenerPdf createState() => _GenerPdf();
}

  class _GenerPdf extends State<GenerPdf>{*/
  static pw.Document pdf = new pw.Document();

  //chaque 'ligne' du PDF sont très similaire alors pour les faire une methode a ete appeler pour creer un ligne du PDF
  static writeOnPdf(EnlevementData enlevement) {
    pdf = new pw.Document();
    pdf.addPage(
        pw.MultiPage(

            pageFormat: PdfPageFormat.a4,
            margin: pw.EdgeInsets.all(54),
            build: (pw.Context context) {
              return <pw.Widget>[
                pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Row(
                      children: <pw.Widget>[
                        pw.Container(
                          height: 183,
                          width: 243,
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(width: 1,),
                          ),
                          child: pw.Text('Image du camp Romain',
                            style: pw.TextStyle(fontSize: 16,),),
                        ),
                        pw.Container(
                          height: 183,
                          width: 182,
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(width: 1,),
                          ),
                          child: pw.Text(
                              'Enlèvement d\'Eau \n De Vie à la Propriété'),
                        ),
                      ],
                    ),
                    RowPdf('Date', '${enlevement.getDate()}'),
                    RowPdf('Viticulteur', '${enlevement.getViticulteur()}'),
                    RowPdf('Viticulteur Présent',
                        '${enlevement.getVitiPresent()}'),
                    RowPdf('Immatriculation du Camion',
                        '${enlevement.getImmatriculation()}'),
                    RowPdf('Destination', '${enlevement.getDestination()}'),
                    RowPdf('Volume HLAP à Charger',
                      '${enlevement.getVolumeApACharger()}', margin: 27,
                      unit: true,
                      uniter: 'HLAP',),
                    RowPdf('Température EDV', '${enlevement.getTemperature()}',
                        unit: true, uniter: '°C'),
                    RowPdf('Degré EDV', '${enlevement.getDegre()}', unit: true,
                        uniter: '°'),
                    RowPdf('Degré rectifié', '${enlevement.getDegreReel()}',
                        unit: true, uniter: '°'),
                    RowPdf('Coefficient', '${enlevement.getCoeficient()}',
                      unit: true,),
                    RowPdf('Volume Brut', '${enlevement.getVolumeBrut()}',
                        unit: true, uniter: 'HL VOL'),
                    RowPdf('Volume Camion à Charger',
                        '${enlevement.getVolumeACharger()}', unit: true,
                        uniter: 'HL VOL'),
                    RowPdf('Volume Arrondi chargé',
                        '${enlevement.getVolumeArrondiCharge()}', unit: true,
                        uniter: 'HL VOL'),
                    RowPdf('Volume Brut Chargé',
                        '${enlevement.getVolumeRectifier()}', unit: true,
                        uniter: 'HL VOL'),
                    RowPdf('HL AP CHARGE', '${enlevement.getVolumeApCharge()}',
                        unit: true, uniter: 'HL '),

                  ],
                )
              ];
            }
        )
    );
  }

  //chaque ligne a deux parametre obligatoire le 'nom'/'type' de donne et la donne (qui se trouve dans l'instance de EnlevementData)
  //les Parametre optionnele sont plus pour les Donne concernant l'expedition d'eau de vie elle permete d'ajouter une nouvelle case avec l'uniter de mesure de la pese
  // la margin quant a elle est utiliser pour faire la separation entre les information est l'expedition
  static pw.Widget RowPdf(String nom, String donnee,
      {double margin = 0.00, bool unit = false, String uniter = '',}) {
    return pw.Row(
        children: [
          pw.Container(
            //color: colors,
            margin: pw.EdgeInsets.only(top: margin),
            height: 27,
            width: 243,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: 1,),
            ),
            child: pw.Text('$nom', style: pw.TextStyle(fontSize: 16,),
                textAlign: pw.TextAlign.center),
          ),
          pw.Container(
            //color : colors,
            margin: pw.EdgeInsets.only(top: margin),
            height: 27,
            width: 182,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: 1,),
            ),
            child: pw.Text('$donnee', style: pw.TextStyle(fontSize: 16,),
                textAlign: pw.TextAlign.right),
          ),
          (unit == false ? pw.Container() : pw.Container(
            //color: colors,
            margin: pw.EdgeInsets.only(top: margin),
            height: 27,
            width: 61,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: 1,),
            ),
            child: pw.Text('$uniter', style: pw.TextStyle(fontSize: 16,),),
          )
          ),

        ]);
  }

  Future savePdf() async {
    Directory document = await getApplicationDocumentsDirectory();
    String documentPath = document.path;
    File file = File('$documentPath/exemple.pdf');
    file.writeAsBytesSync(await pdf.save());
    //file.writeAsBytesSync(pdf.save());
  }

  Future<String> getPath() async {
    Directory document;
    document = await getApplicationDocumentsDirectory();
    String documentPath = document.path;

    return documentPath;
  }

  //cette methode fait aparaitre un popUp qui permet d'imprimmer ou de telecharger le Pdf
  static Future<void> impresion() async {
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }
}