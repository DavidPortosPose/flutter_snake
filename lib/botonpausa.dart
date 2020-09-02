import 'package:flutter/material.dart';

class BotonPausa extends StatefulWidget{
  bool enPausa = false;
  Function funcionCb;
  GlobalKey<BotonPausaState> key;
  BotonPausa(this.key,this.funcionCb) : super(key:key);

  reiniciar(){
    key.currentState.reiniciar();
  }

  cambiarEstado(){
    key.currentState.cambiarEstado();
  }

  @override
  State createState() {
    return BotonPausaState();
  }
}

class BotonPausaState extends State<BotonPausa>{
  cambiarEstado(){
    setState(() {
      widget.enPausa = ! widget.enPausa;
    });
  }

  reiniciar(){
    setState(() {
      widget.enPausa = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(widget.enPausa ? Icons.play_arrow : Icons.pause),
      onPressed: (){
        cambiarEstado();
        widget.funcionCb();
      },
    );
  }
}
