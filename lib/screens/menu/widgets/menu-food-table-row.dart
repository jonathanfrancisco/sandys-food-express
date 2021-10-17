import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandys_food_express/constants.dart';

import '../menu-view-model.dart';

class MenuFoodTableRow extends StatefulWidget {
  final int _id;
  final String _name;
  final double _price;
  final Function _onMenuFoodTableRowSelect;
  final bool _hasActions;
  bool _isSelected;

  MenuFoodTableRow({
    required int id,
    required String name,
    required double price,
    required String picture,
    required Function onMenuFoodTableRowSelect,
    bool hasActions = false,
    required bool isSelected,
  })  : _id = id,
        _name = name,
        _price = price,
        _onMenuFoodTableRowSelect = onMenuFoodTableRowSelect,
        _hasActions = hasActions,
        _isSelected = isSelected;

  @override
  MenuFoodTableRowState createState() => MenuFoodTableRowState();
}

class MenuFoodTableRowState extends State<MenuFoodTableRow> {
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
            value: this.widget._isSelected,
            onChanged: (bool? value) {
              this.widget._onMenuFoodTableRowSelect(this.widget._id);
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
          if (this.widget._hasActions)
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
                  },
                ),
              ],
            )
        ],
      ),
    );
  }
}
