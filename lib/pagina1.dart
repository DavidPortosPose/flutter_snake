import 'package:flutter/material.dart';
import 'package:flutter_snake/botonpausa.dart';
import 'package:flutter_snake/contador.dart';
import 'package:flutter_snake/paginaformulario.dart';
import 'package:flutter_snake/rejilla.dart';

class Pagina1 extends StatelessWidget{
  Rejilla rejilla;
  BotonPausa botonPausa;
  Contador contador;
  botonPausaClick(){
    if (botonPausa.enPausa) rejilla.pararTimer();
    else rejilla.iniciarTimer();
  }

  @override
  Widget build(BuildContext context) {
    contador = Contador(GlobalKey<ContadorState>());
    rejilla = Rejilla(GlobalKey<RejillaState>(),contador);
    botonPausa = BotonPausa(GlobalKey<BotonPausaState>(),botonPausaClick);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text('Snake '),
            contador
          ],
        ),
        actions: <Widget>[
          botonPausa,
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: (){
              rejilla.reiniciar();
              botonPausa.reiniciar();
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: (){
              if (!botonPausa.enPausa){
                botonPausa.cambiarEstado();
                rejilla.pararTimer();
              }

              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaginaFormulario())
              );
            },
          )
        ],
      ),
        body: rejilla
    );
  }
}