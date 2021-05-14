import 'package:flutter/material.dart';
import 'package:sandys_food_express/constants.dart';

class MenuFoodTableRow extends StatefulWidget {
  @override
  MenuFoodTableRowState createState() => MenuFoodTableRowState();
}

class MenuFoodTableRowState extends State<MenuFoodTableRow> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: borderColor,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Checkbox(
            activeColor: primaryColor,
            value: this.isSelected,
            onChanged: (bool? value) {
              setState(() {
                this.isSelected = !this.isSelected;
              });
            },
          ),
          Text(
            'Kare Kare',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            '70.00',
            style: TextStyle(
              fontSize: 16,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.edit,
                color: primaryColor,
              ),
              Icon(
                Icons.delete,
                color: primaryColor,
              )
            ],
          )
        ],
      ),
    );
  }
}
