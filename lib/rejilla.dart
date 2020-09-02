import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake/contador.dart';
import 'package:flutter_snake/posicion.dart';

class Coordenada{
  int fila;
  int columna;
  Coordenada(this.fila,this.columna);
}

enum Direccion{
  ARRIBA,
  ABAJO,
  IZQUIERDA,
  DERECHA
}


class Rejilla extends StatefulWidget{

  GlobalKey<RejillaState> key;
  Contador contador;

  Rejilla(this.key,this.contador): super(key: key);


  reiniciar(){
    key.currentState.reiniciar();
  }
  iniciarTimer(){
    key.currentState.iniciarTimer();
  }

  pararTimer(){
    key.currentState.cancelarTimer();
  }




  @override
  State createState() {
    return RejillaState();

  }


}

class RejillaState extends State<Rejilla>{

  final int MAXFILAS = 35;
  final int MAXCOLUMNAS = 27;
  List<List<Posicion>> matriz;
  List<Row> matrizVisualFilas;
  List<Coordenada> serpiente;
  Direccion direccionSerpiente = Direccion.ABAJO;
  Timer timer = null;
  Coordenada comida = Coordenada(15, 15);
  List<Coordenada> comidasAnteriores=[];


  RejillaState(){
    inicializarMatriz();
    inicializarSerpiente();
    inicializarComida();
    inicializarMatrizVisulaFilas();
    iniciarTimer();
  }
  @override
  void dispose(){
    cancelarTimer();
    super.dispose();
  }

  reiniciar(){
    cancelarTimer();
    direccionSerpiente = Direccion.ABAJO;
    for(int fila = 0; fila < MAXFILAS; fila++)
      for(int columna = 0; columna < MAXCOLUMNAS; columna++)
        matriz[fila][columna].cambiarEstado(EstadoPosicion.VACIO);

    inicializarSerpiente();
    inicializarComida();
    iniciarTimer();
    widget.contador.ponerACero();
  }

  iniciarTimer(){
    cancelarTimer();
    timer = Timer.periodic(Duration(milliseconds: 300), moverSerpiente);
  }
  cancelarTimer(){
    if (timer!= null)
      timer.cancel();
  }


  bool haPerdido(){
    bool resultado;
    int fila = serpiente[serpiente.length-1].fila;
    int columna = serpiente[serpiente.length-1].columna;

    //Comprobar no toca los bordes
    resultado = (fila < 0) || (fila >= MAXFILAS) ||
        (columna < 0) || (columna >= MAXCOLUMNAS);
    //Comprobar no se toca a si misma
    if (! resultado){
      for(int i = 0; i < serpiente.length-1; i++){
        if ((serpiente[i].fila == fila) &&
          (serpiente[i].columna==columna))
          resultado = true;
      }
    }


    return resultado;
  }

  int colaEnComidasAnteriores(){
    int resultado = -1;
    for (int i =0; i< comidasAnteriores.length; i++)
      if ((serpiente[0].fila == comidasAnteriores[i].fila) &&
    (serpiente[0].columna == comidasAnteriores[i].columna))
        resultado = i;

      return resultado;
  }

  moverSerpiente(Timer t){
    //1 En la rejilla pintar vacio en su cola
    int fila = serpiente[0].fila;
    int columna = serpiente[0].columna;
    int posicionComidasAnteriores;
      posicionComidasAnteriores = colaEnComidasAnteriores();
      if (posicionComidasAnteriores > 0){
       comidasAnteriores.removeAt(posicionComidasAnteriores);
      }
      else {
        //Quitar la cola de la serpiente
        matriz[fila][columna].cambiarEstado(EstadoPosicion.VACIO);
        serpiente.remove(serpiente[0]);
      }


    //3 anadir nueva coordenada
    fila = serpiente[serpiente.length-1].fila;
    columna = serpiente[serpiente.length-1].columna;
    if ((comida.fila == fila) && (comida.columna == columna)){
      widget.contador.aumentarUno();
      comidasAnteriores.add(Coordenada(fila, columna));
      inicializarComida();
    }


    if (direccionSerpiente==Direccion.ABAJO) fila++;
    else if (direccionSerpiente==Direccion.ARRIBA) fila--;
    else if (direccionSerpiente==Direccion.DERECHA) columna++;
    else columna--;
    serpiente.add(Coordenada(fila, columna));
    //Pintar la cabeza de serpiente;
    if (haPerdido()) {
      cancelarTimer();
      mostrarMensajeFinalizado();
    }
    else matriz[fila][columna].cambiarEstado(EstadoPosicion.SERPIENTE);
  }

  inicializarSerpiente(){
    serpiente = [];
    int tamano = 4;
    for (int i = 0; i < tamano; i++) {
      serpiente.add(Coordenada(i, 0));
      matriz[i][0].cambiarEstado(EstadoPosicion.SERPIENTE);
    }
  }

  inicializarComida(){
    Random aleatrorio = Random();
    bool valida = false;
    int fila,columna;
    while (! valida) {
      fila = aleatrorio.nextInt(MAXFILAS);
      columna = aleatrorio.nextInt(MAXCOLUMNAS);
      if (matriz[fila][columna].estado == EstadoPosicion.VACIO) valida = true;
    }
    comida.fila = fila;
    comida.columna = columna;
    matriz[comida.fila][comida.columna].cambiarEstado(EstadoPosicion.COMIDA);
  }

  inicializarMatriz(){
    matriz = [];
    for(int fila=0; fila < MAXFILAS; fila++){
      List<Posicion> matrizFila = [];
      for(int columna =0; columna < MAXCOLUMNAS; columna++){
        matrizFila.add(Posicion(key: GlobalKey<PosicionState>()));
      }
      matriz.add(matrizFila);
    }
  }
  inicializarMatrizVisulaFilas(){
    //Construir una matriz de filas a mostrar
    matrizVisualFilas = [];
    matrizVisualFilas.add(Row(
      children: <Widget>[
        Container(padding: EdgeInsets.only(top: 3),)
      ],
    ));
    for(int fila=0; fila < MAXFILAS; fila++){
      List<Posicion> matrizFila = [];
      for(int columna =0; columna < MAXCOLUMNAS; columna++){
        matrizFila.add(matriz[fila][columna]);
      }
      matrizVisualFilas.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: matrizFila)
      );
    }
    matrizVisualFilas.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_left),
            iconSize: 50,
            onPressed: (){
              direccionSerpiente = direccionSerpiente == Direccion.DERECHA ?
                                  direccionSerpiente : Direccion.IZQUIERDA;

            },
          ),
          IconButton(
            icon: Icon(Icons.arrow_drop_up),
            iconSize: 50,
            onPressed: (){
              direccionSerpiente = direccionSerpiente == Direccion.ABAJO ?
              direccionSerpiente : Direccion.ARRIBA;

            },
          ),
          IconButton(
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 50,
            onPressed: (){
              direccionSerpiente = direccionSerpiente == Direccion.ARRIBA ?
              direccionSerpiente : Direccion.ABAJO;

            },
          ),
          IconButton(
            icon: Icon(Icons.arrow_right),
            iconSize: 50,
            onPressed: (){
              direccionSerpiente = direccionSerpiente == Direccion.IZQUIERDA ?
              direccionSerpiente : Direccion.DERECHA;

            },
          )
        ],)
    );
  }



  mostrarMensajeFinalizado(){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
            title: Text('Has Perdido')
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: matrizVisualFilas,
    );

  }
}

