  import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';

class View extends StatelessWidget{
  String path;
  View({this.path});

  @override
  Widget build(BuildContext context){
    return PDFViewerScaffold(path: this.path
    );
  }
}