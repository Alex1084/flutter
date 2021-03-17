import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
class MacroPdf extends StatefulWidget{
  _MacroPdf  createState() => _MacroPdf();
}
class _MacroPdf extends State<MacroPdf> {
  final pdf = pw.Document();
  final f = new DateFormat('yMd');

  writeOnPdf() {
    pdf.addPage(
        pw.MultiPage(
            pageFormat: PdfPageFormat.a4,
            margin: pw.EdgeInsets.all(32),
            build: (pw.Context context) {
              return <pw.Widget>[
                pw.Container(
                  child: pw.Column(
                    children: [
                      pw.Row(
                        children: <pw.Widget>[
                          pw.Container(
                            child: pw.Text(
                              'Date', style: pw.TextStyle(fontSize: 16,),),
                          ),
                          pw.Container(
                            child: pw.Text('12/11/20'),
                          ),
                        ],
                      ),
                      pw.Row(
                        children: <pw.Widget>[
                          pw.Container(
                            child: pw.Text('Viticulteur'),
                          ),
                          pw.Container(
                            child: pw.Text('Dist. Camp Romain'),
                          ),
                        ],
                      ),
                      pw.Row(
                        children: <pw.Widget>[
                          pw.Container(
                            child: pw.Text('Immatriculation'),
                          ),
                          pw.Container(
                            child: pw.Text('ZE 955 TY'),
                          ),
                        ],
                      ),
                      pw.Row(
                        children: <pw.Widget>[
                          pw.Container(
                            child: pw.Text('Destination'),
                          ),
                          pw.Container(
                            child: pw.Text('Cognac'),
                          ),
                        ],
                      )
                    ],

                  ),
                ),
              ];
            }
        )
    );
  }

  Widget build(BuildContext context) {
    return Scaffold();
  }
}