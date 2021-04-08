import 'package:alarmfy/src/vista/screens/Inicio.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appi Music',
      debugShowCheckedModeBanner: false,
      home: Inicio(),
    );
  }
}
