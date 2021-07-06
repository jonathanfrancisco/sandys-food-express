import 'package:flutter/material.dart';
import 'package:sandys_food_express/screens/home/home.dart';
import 'package:sandys_food_express/screens/signin/signin.dart';
import 'package:sandys_food_express/screens/signup/signup.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Sandy's Food Express",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/sign-in',
      routes: {
        SignIn.routeName: (context) => SignIn(),
        SignUp.routeName: (context) => SignUp(),
        Home.routeName: (context) => Home()
      },
    );
  }
}
