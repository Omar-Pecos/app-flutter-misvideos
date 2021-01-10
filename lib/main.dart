import 'package:apm_pip/components/listOfApms.dart';
import 'package:flutter/material.dart';

 void main() { 
 runApp(
   MaterialApp( 
      title: 'APM PIP',
      home : MyApp(),
      theme: ThemeData.dark(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListOfApms();
  }
}
