import 'package:flutter/material.dart';

import 'package:sandys_food_express/constants.dart';

class MenuFoodTableInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: new BoxDecoration(
            color: primaryColor,
            shape: BoxShape.circle,
          ),
          child: Text(
            ' ',
            style: TextStyle(fontSize: 40),
          ),
        ),
        SizedBox(width: 6),
        Text('Select all item available in a specific date'),
      ],
    );
  }
}
