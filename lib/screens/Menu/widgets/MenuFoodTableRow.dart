import 'package:flutter/material.dart';
import 'package:sandys_food_express/constants.dart';

class MenuFoodTableRow extends StatefulWidget {
  final int _id;
  final String _name;
  final double _price;
  final String _picture;
  final void Function(int) _onDeleteFood;

  MenuFoodTableRow(
      {required int id,
      required String name,
      required double price,
      required String picture,
      required void Function(int) onDeleteFood})
      : _id = id,
        _name = name,
        _price = price,
        _picture = picture,
        _onDeleteFood = onDeleteFood;

  @override
  MenuFoodTableRowState createState() => MenuFoodTableRowState();
}

class MenuFoodTableRowState extends State<MenuFoodTableRow> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            this.widget._name,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            this.widget._price.toString(),
            style: TextStyle(
              fontSize: 16,
              color: primaryColor,
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.edit_outlined,
                color: primaryColor,
              ),
              GestureDetector(
                  child: Icon(
                    Icons.delete_outlined,
                    color: primaryColor,
                  ),
                  onTap: () {
                    this.widget._onDeleteFood(this.widget._id);
                  }),
            ],
          )
        ],
      ),
    );
  }
}
