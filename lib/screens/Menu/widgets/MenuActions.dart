import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

import 'package:sandys_food_express/screens/Menu/widgets/AddFoodModal.dart';

import 'package:sandys_food_express/constants.dart';

class MenuActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: accentColor,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          ),
          onPressed: () {},
          child: Text(
            'View Menu',
            style: TextStyle(
              fontSize: 16,
              color: primaryColor,
            ),
          ),
        ),
        SizedBox(width: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: accentColor,
            padding: EdgeInsets.all(11),
          ),
          onPressed: () {
            showAnimatedDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return AddFoodModal();
              },
            );
          },
          child: Icon(
            Icons.add,
            color: Colors.black,
            size: 18,
          ),
        ),
      ],
    );
  }
}
