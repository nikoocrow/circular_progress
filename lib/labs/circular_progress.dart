import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class CircularProgressPage extends StatefulWidget {
 

  @override
  State<CircularProgressPage> createState() => _CircularProgressPageState();
}

class _CircularProgressPageState extends State<CircularProgressPage> with SingleTickerProviderStateMixin{

  late AnimationController animcontroller;
  double porcentaje = 0.0;
  double nuevoPorcentaje = 0.0;



  @override
  void initState() {
    animcontroller = new AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    animcontroller.addListener(() {
       // print('Valor Controller : ${animcontroller.value}');
       setState(() {
          porcentaje = lerpDouble(porcentaje, nuevoPorcentaje, animcontroller.value)!;
       });
       
    });
    super.initState();
  }

 @override
  void dispose() {
    animcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.refresh),
          backgroundColor: Colors.pink,
          onPressed: (){

            porcentaje = nuevoPorcentaje;
            nuevoPorcentaje += 10;
            if(nuevoPorcentaje > 100){
              nuevoPorcentaje = 0;
              porcentaje = 0;
            }


            animcontroller.forward(from: 0.0);

            setState(() {});

          }
        ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(5),
          width: 300,
          height: 300,
          //color: Colors.red, 
          child: CustomPaint(
            painter: _MiRadialProgress(porcentaje),
          ),
        ),
      ),
    );
  }
}







class _MiRadialProgress extends CustomPainter{

   final porcentaje;

  _MiRadialProgress(this.porcentaje);


  @override
  void paint(Canvas canvas, Size size) {
    
    // CIRCULO COMPLETADO

    final paint = new Paint()
        
        //lapiz
        ..strokeWidth = 7
        ..color       = Colors.grey
        ..style       = PaintingStyle.stroke;

        final Offset center = new Offset(size.width * 0.5, size.height / 2);
        final double radio  = min(size.width * 0.5, size.height * 0.5);

        canvas.drawCircle(center, radio, paint);


        //ARCO

        final paintArco = new Paint()
        
        //lapiz
        ..strokeWidth = 14
        ..color       = Colors.pink
        ..style       = PaintingStyle.stroke;


        //Parte que se debera ir llenando

        double arcAngle = 2 * pi * (porcentaje / 100);
        canvas.drawArc(
              Rect.fromCircle(center: center, radius: radio),
              -pi / 2,
              arcAngle,
              false,
              paintArco
          );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}