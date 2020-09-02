import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaginaFormulario extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro')
      ),
      body: Formulario()
    );
  }
}

class Formulario extends StatefulWidget{

  @override
  State createState() {
    return FormularioState();
  }
}


class FormularioState extends State<Formulario>{
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController controladorNombre = TextEditingController();


  @override
  void dispose(){
    controladorNombre.dispose();
    super.dispose();
  }

  FormularioState(){
    leerDelDisco();
  }

  leerDelDisco() async{
    final prefs = await SharedPreferences.getInstance();
    controladorNombre.text= prefs.getString('nombre');
  }


  guardarEnDisco() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('nombre', controladorNombre.text);
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Form(
          key: key,
          child: Column(
            children: <Widget>[
              TextFormField(

                validator: (valor){
                  String resultado = null;
                  if (valor.isEmpty) resultado='Debe rellenar el campo';

                  return resultado;
                },
                decoration: InputDecoration(
                  hintText: 'Nombre'
                ),
                controller: controladorNombre,
              )
            ],
          ),
        ),
        RaisedButton(
          child: Text('Aceptar'),
          onPressed: (){
              if (key.currentState.validate()){
                guardarEnDisco();
                Navigator.pop(context);
              }
          },
        )
      ],
    );
  }
}