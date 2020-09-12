import 'dart:convert';
import './sharedPref.dart';
import './user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './gmap.dart';
import 'main.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SharedPref sp = SharedPref();
  User us = User();
  User ul = User();


  loadSharedPrefs() async {
    try {
      User user = User.fromJson(await sp.read("user"));
      setState(() {ul = user;});
      if (ul.eml!= null) {
        setState(() {
          isLoggedIn = true;
        });
      }


    } catch (Excepetion) {
      print('bhai hisab se re');
    }
  }

  bool isLoggedIn = false;


  @override
  void initState() {
    super.initState();
    // autoLogIn();
    loadSharedPrefs();}

  Future<Null> logout() async {
    setState(() {
      isLoggedIn = false;
      sp.remove('user');
    });}

  Future<Null> loginUser() async {
    await sp.save("user",us.toJson());
    setState(() {
      isLoggedIn = true;
      loadSharedPrefs();
    });}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: !isLoggedIn ? AppBar(
        title: Text('Login Page'),
      )
          : AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            !isLoggedIn ? Container(
              padding: EdgeInsets.only(left: 40.0,right: 50.0,bottom: 30.0,top: 60),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    textAlign: TextAlign.center,
                    //controller: nameController,
                    onChanged: (value){
                      setState(() async{
                        us.eml = value;
                      });
                    },
                    decoration: InputDecoration(hintText: 'E-mail'),),
                  TextField(
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    //controller: passController,
                    onChanged: (value){
                      setState(() async{
                        us.pas = value;
                      });
                    },
                    decoration: InputDecoration(
                        hintText: 'Password'),)
                ],
              ),
            ) : Column(
              children: [
                RaisedButton(
                    color: Colors.indigo,
                    child: Text('Map=>'),
                    onPressed: (){
                      Navigator.pushNamed(context, '/map');
                    }
                ),
                Text('You are logged in as ${ul.eml}'),
                Text('and your password is ${ul.pas}'),

              ],
            ),
            SizedBox(height: 10.0),
            RaisedButton(
              color: isLoggedIn ? Colors.tealAccent : Colors.blue,
              onPressed: () {
                isLoggedIn ? logout() : loginUser();
              },
              child: isLoggedIn ? Text('Logout') : Text('Login'),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
