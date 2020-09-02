import 'package:flutter/material.dart';

class Contador extends StatefulWidget{

  GlobalKey<ContadorState> key;
  Contador(this.key) : super(key: key);

  ponerACero(){
    key.currentState.ponerACero();
  }
  aumentarUno(){
    key.currentState.aumentarUno();
  }

  @override
  State createState() {
    return ContadorState();
  }
}

class ContadorState extends State<Contador>{
  int contador=0;

  ponerACero(){
    setState(() {
      contador = 0;
    });
  }

  aumentarUno(){
    setState(() {
      contador++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(contador.toString());
  }
}