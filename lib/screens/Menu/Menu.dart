import 'package:flutter/material.dart';

import 'package:sandys_food_express/screens/Menu/widgets/MenuActions.dart';
import 'package:sandys_food_express/screens/Menu/widgets/MenuFoodTableInfo.dart';
import 'package:sandys_food_express/screens/Menu/widgets/MenuFoodTable.dart';

class Menu extends StatefulWidget {
  static final String routeName = '/menu';
  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF9F9F9),
      ),
      width: double.maxFinite,
      child: Container(
        padding: EdgeInsets.only(top: 12, left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            MenuActions(),
            SizedBox(height: 8),
            MenuFoodTableInfo(),
            MenuFoodTable(),
            SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
