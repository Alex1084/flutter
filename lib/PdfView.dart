  import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';


//cette classe est inutiliser car son but est de previsualiser un Pdf or le bouton d'impression permet deja de le faire
class View extends StatelessWidget{
  String path;
  View({this.path});

  @override
  Widget build(BuildContext context){
    return PDFViewerScaffold(path: this.path
    );
  }
}