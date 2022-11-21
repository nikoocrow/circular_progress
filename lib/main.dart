import 'package:circular_progress/labs/circular_progress.dart';
import 'package:circular_progress/pages/graficas_circulares_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Circular Progress App',
      home: GraficaCirculares()
    );
  }
}