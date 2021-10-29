import 'package:flutter/material.dart';
import 'package:sandys_food_express/constants.dart';
import 'package:sandys_food_express/models/Food.dart';

class MenuFoodTableRow extends StatefulWidget {
  final Food _food;
  final Function _onMenuFoodTableRowSelect;
  final Function _onMenuFoodTableRowDelete;
  final bool _hasActions;
  bool _isSelected;

  MenuFoodTableRow({
    required Food food,
    required Function onMenuFoodTableRowSelect,
    required Function onMenuFoodTableRowDelete,
    bool hasActions = false,
    required bool isSelected,
  })  : _food = food,
        _onMenuFoodTableRowSelect = onMenuFoodTableRowSelect,
        _hasActions = hasActions,
        _onMenuFoodTableRowDelete = onMenuFoodTableRowDelete,
        _isSelected = isSelected;

  @override
  MenuFoodTableRowState createState() => MenuFoodTableRowState();
}

class MenuFoodTableRowState extends State<MenuFoodTableRow> {
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
            value: this.widget._isSelected,
            onChanged: (bool? value) {
              this.widget._onMenuFoodTableRowSelect(this.widget._food.id);
            },
          ),
          Text(
            this.widget._food.name,
            style: TextStyle(),
          ),
          Text(
            this.widget._food.price.toString(),
            style: TextStyle(
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
                  onTap: () => this.widget._onMenuFoodTableRowDelete,
                ),
              ],
            )
        ],
      ),
    );
  }
}
