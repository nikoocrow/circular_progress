import 'package:circular_progress/widget/radial_progress.dart';
import 'package:flutter/material.dart';

class GraficaCirculares extends StatefulWidget {
  

  @override
  State<GraficaCirculares> createState() => _GraficaCircularesState();
}

class _GraficaCircularesState extends State<GraficaCirculares> {

  double porcentaje = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: (() {
            setState(() {
               porcentaje+=10;
               if(porcentaje > 100){
                porcentaje = 0;
               }
            });
        }
      ),
    ),
    body: Center(
        child: Container(
          width: 300,
          height: 300,
          //color: Colors.red,
          child: RadialProgressWidget(porcentaje: porcentaje),
         // child: Text('$porcentaje %', style: TextStyle(fontSize: 50),),
        )
      ),
    );
  }
}