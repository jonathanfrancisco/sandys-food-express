import 'package:flutter/material.dart';
import 'package:sandys_food_express/screens/Menu/widgets/MenuFoodTableRow.dart';

import '../../../constants.dart';

class MenuFoodTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: borderColor,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: false,
                  onChanged: (bool? value) {},
                ),
                Text(
                  '4 items',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          MenuFoodTableRow(),
          MenuFoodTableRow(),
          MenuFoodTableRow(),
          MenuFoodTableRow(),
          MenuFoodTableRow(),
        ],
      ),
    );
  }
}
