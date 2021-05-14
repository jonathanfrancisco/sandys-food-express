import 'package:flutter/material.dart';
import 'package:sandys_food_express/screens/Home/Home.dart';
import 'package:sandys_food_express/screens/SignIn/SignIn.dart';
import 'package:sandys_food_express/screens/SignUp/SignUp.dart';

// store current page
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // List<DrawerItem> drawerItems = [
    //   DrawerItem(icon: Icon(Icons.add), title: 'QUEUE', to: '/orders-queue'),
    //   DrawerItem(icon: Icon(Icons.add), title: 'MENU', to: '/menu'),
    // ].map((e) {
    //   if (currentPage == e.title) {
    //     e.isActive = true;
    //     return e;
    //   }
    //   return e;
    // }).toList();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/sign-in',
      routes: {
        SignIn.routeName: (context) => SignIn(),
        SignUp.routeName: (context) => SignUp(),
        '/home': (context) => Home()
      },
    );
  }
}
