import 'package:flutter/material.dart';
import 'package:sandys_food_express/constants.dart';

class DrawerItem extends StatelessWidget {
  final Icon _icon;
  final String _title;
  final bool _isActive;
  final Function _onPress;

  DrawerItem(
      {required Icon icon,
      required String title,
      bool isActive = false,
      required Function onPress})
      : _title = title,
        _icon = icon,
        _isActive = isActive,
        _onPress = onPress;

  @override
  Widget build(BuildContext context) {
    return TextButton(
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
        backgroundColor: _isActive ? primaryColor : accentColor,
        primary: _isActive ? Colors.white : primaryColor,
      ),
      child: Row(
        children: [
          _icon,
          SizedBox(width: 10),
          Text(_title),
        ],
      ),
      onPressed: () {
        _onPress();
      },
    );
  }
}
