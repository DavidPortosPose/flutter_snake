import 'package:flutter/material.dart';
import 'package:flutter_snake/pagina1.dart';
import 'package:flutter_snake/paginainicio.dart';

main () => runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PaginaInicio()
    );
  }
}