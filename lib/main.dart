
import 'package:flutter/material.dart';
import 'auth_screen.dart';  
import 'item_model.dart';
import 'item_detail_screen.dart';
import 'add_item_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Моя коллекция',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthScreen(), 
    );
  }
}
