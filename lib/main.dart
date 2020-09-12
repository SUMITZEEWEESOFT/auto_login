import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './gmap.dart';
import './mhp.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'Auto Login',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        initialRoute: '/',
      routes: {
          '/':(context) => MyHomePage(),
        '/map':(context) => Map(),


      },
    );
  }
}
