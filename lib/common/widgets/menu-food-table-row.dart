import 'package:flutter/material.dart';
import 'package:sandys_food_express/constants.dart';
import 'package:sandys_food_express/models/Food.dart';

class MenuFoodTableRow extends StatefulWidget {
  final Food _food;
  final Function _onMenuFoodTableRowSelect;
  final Function _onMenuFoodTableRowDelete;
  final bool _hasActions;
  bool _isSelected;
  final bool _isDisabled;

  MenuFoodTableRow({
    required Food food,
    required Function onMenuFoodTableRowSelect,
    required Function onMenuFoodTableRowDelete,
    bool hasActions = false,
    required bool isSelected,
    bool isDisabled = false,
  })  : _food = food,
        _onMenuFoodTableRowSelect = onMenuFoodTableRowSelect,
        _hasActions = hasActions,
        _onMenuFoodTableRowDelete = onMenuFoodTableRowDelete,
        _isSelected = isSelected,
        _isDisabled = isDisabled;

  @override
  MenuFoodTableRowState createState() => MenuFoodTableRowState();
}

class MenuFoodTableRowState extends State<MenuFoodTableRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: this.widget._isSelected ? accentColor : null,
        border: Border(
          bottom: BorderSide(
            color: borderColor,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Checkbox(
            activeColor: primaryColor,
            value: this.widget._isSelected,
            onChanged: this.widget._isDisabled
                ? null
                : (bool? value) {
                    this.widget._onMenuFoodTableRowSelect(this.widget._food.id);
                  },
          ),
          Text(
            this.widget._food.name,
            style: TextStyle(
                color: this.widget._isDisabled ? disabledColor : null),
          ),
          Text(
            this.widget._food.price.toString(),
            style: TextStyle(
              color: this.widget._isDisabled ? disabledColor : primaryColor,
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
