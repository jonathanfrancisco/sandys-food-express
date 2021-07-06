import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandys_food_express/constants.dart';

import '../menu_view_model.dart';

class MenuFoodTableRow extends StatefulWidget {
  final int _id;
  final String _name;
  final double _price;
  final String _picture;

  MenuFoodTableRow({
    required int id,
    required String name,
    required double price,
    required String picture,
  })   : _id = id,
        _name = name,
        _price = price,
        _picture = picture;

  @override
  MenuFoodTableRowState createState() => MenuFoodTableRowState();
}

class MenuFoodTableRowState extends State<MenuFoodTableRow> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    MenuViewModel menuViewModel =
        Provider.of<MenuViewModel>(context, listen: false);
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
                  onTap: () async {
                    await menuViewModel.deleteFood(this.widget._id);
                    await menuViewModel.loadFoods();
                  }),
            ],
          )
        ],
      ),
    );
  }
}
