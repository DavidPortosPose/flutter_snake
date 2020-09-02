import 'package:flutter/material.dart';

enum EstadoPosicion{
  VACIO,
  SERPIENTE,
  COMIDA
}
class Posicion extends StatefulWidget{
  EstadoPosicion estado = EstadoPosicion.VACIO;
  GlobalKey<PosicionState> key;

  Posicion({@required this.key}) : super (key: key);


  cambiarEstado(EstadoPosicion nuevoEstado){
    this.estado = nuevoEstado;
    PosicionState p = key.currentState;
    if (p != null) p.cambiarEstado(nuevoEstado);
  }

  @override
  State createState() {
    return PosicionState();
  }
}


class PosicionState extends State<Posicion>{

  cambiarEstado(EstadoPosicion nuevoEstado ){
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    Color color = Colors.black;
    if (widget.estado == EstadoPosicion.SERPIENTE) color = Colors.green;
    else if (widget.estado == EstadoPosicion.COMIDA) color = Colors.red;
    return Container(
      color: color,
      width: 15,
      height: 15,
    );
  }
}