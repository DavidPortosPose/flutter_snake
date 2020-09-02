import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake/pagina1.dart';

class PaginaInicio extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
            color: Colors.black,
            child: Center(
              child: ColorizeAnimatedTextKit(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Pagina1()),
                  );
                },
                text: [
                  "Snake",
                ],
                textStyle: TextStyle(
                    fontSize: 80.0,
                    fontFamily: "Horizon"
                ),
                colors: [
                  Colors.purple,
                  Colors.blue,
                  Colors.yellow,
                  Colors.red,
                ],
              ),
            )
          )
      )
    );
  }
}