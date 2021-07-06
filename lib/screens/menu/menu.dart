import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:provider/provider.dart';
import 'package:sandys_food_express/screens/menu/menu_view_model.dart';

import 'package:sandys_food_express/screens/menu/widgets/menu_food_table_info.dart';
import 'package:sandys_food_express/screens/menu/widgets/menu_food_table.dart';
import 'package:sandys_food_express/screens/menu/widgets/add_food_modal.dart';

import 'package:sandys_food_express/constants.dart';

class Menu extends StatelessWidget {
  static final String routeName = '/menu';
  @override
  Widget build(BuildContext context) {
    MenuViewModel menuViewModel =
        Provider.of<MenuViewModel>(context, listen: false);
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF9F9F9),
      ),
      width: double.maxFinite,
      child: Container(
        padding: EdgeInsets.only(top: 12, left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
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
                  onPressed: () async {
                    showAnimatedDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) =>
                            ChangeNotifierProvider<MenuViewModel>.value(
                              value: menuViewModel,
                              child: AddFoodModal(),
                            ));
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 18,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            MenuFoodTableInfo(),
            MenuFoodTable(),
            SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
