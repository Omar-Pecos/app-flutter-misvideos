import 'package:flutter/material.dart';

 void main() { 
 runApp(
   MaterialApp( 
      title: 'APM PIP',
      home : ListOfApms()
    )
  );
}

class ListOfApms extends StatefulWidget {
  ListOfApms({Key key}) : super(key: key);

  @override
  _ListOfApmsState createState() => _ListOfApmsState();
}

class _ListOfApmsState extends State<ListOfApms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de APMs'),
      ),
      body: Text('here goes a list'),
    );
  }
}