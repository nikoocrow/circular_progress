import 'dart:math';

import 'package:flutter/material.dart';

class RadialProgressWidget extends StatefulWidget {

  final porcentaje;

  RadialProgressWidget({this.porcentaje});
 

  @override
  State<RadialProgressWidget> createState() => _RadialProgressWidgetState();
}

class _RadialProgressWidgetState extends State<RadialProgressWidget> with SingleTickerProviderStateMixin{

    late AnimationController animationController;
    double? porcentajeAnterior;

   @override
  void initState() {
    porcentajeAnterior = widget.porcentaje;
    animationController = AnimationController(vsync: this, duration: const Duration(microseconds: 200));

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {

    animationController.forward(from: 0.0);

    final diferenciaAnimar = (widget.porcentaje - porcentajeAnterior);
    print(diferenciaAnimar);
    porcentajeAnterior = widget.porcentaje;

    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child){
       return Container(
        //child: Text( '${widget.porcentaje}'),
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
            painter: _MiRadialProgress( (widget.porcentaje - diferenciaAnimar) + diferenciaAnimar * animationController.value),
            ),

          );
       }
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