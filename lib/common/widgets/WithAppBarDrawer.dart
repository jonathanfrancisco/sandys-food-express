import 'package:flutter/material.dart';
import 'package:sandys_food_express/constants.dart';

class WithAppBarDrawer extends StatelessWidget {
  final Widget body;

  WithAppBarDrawer({
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Row(
            children: [
              SizedBox(
                width: size.width * 0.18,
              ),
              new Container(
                child: Image.asset(
                  'assets/images/sandys_food_express_title.png',
                  width: 130,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
        drawer: Drawer(
          child: Container(
            decoration: BoxDecoration(
              color: accentColor /*  */,
            ),
            child: ListView(
              children: [
                DrawerHeader(
                  child: Text('Drawer Header'),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(0),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 20,
                    ),
                    backgroundColor: primaryColor,
                    primary: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.add),
                      SizedBox(width: 10),
                      Text('QUEUE'),
                    ],
                  ),
                  onPressed: () {},
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 20,
                    ),
                    primary: primaryColor,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.add),
                      SizedBox(width: 10),
                      Text('MENU'),
                    ],
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
        body: this.body,
      ),
    );
  }
}
