import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LocationSelectorScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Location'),),
        body: Container(
          color: Colors.redAccent,
        ),
      ),
    );
  }
  
}