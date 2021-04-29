import 'package:flutter/material.dart';
import 'package:sandys_food_express/common/widgets/WithAppBarDrawer.dart';
import 'package:sandys_food_express/screens/OrdersQueue/OrdersQueue.dart';
import 'package:sandys_food_express/screens/SignIn/SignIn.dart';
import 'package:sandys_food_express/screens/SignUp/SignUp.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/sign-in',
      routes: {
        '/sign-in': (context) => SignIn(),
        '/sign-up': (context) => SignUp(),
        '/orders-queue': (context) => WithAppBarDrawer(body: OrdersQueue()),
      },
    );
  }
}
