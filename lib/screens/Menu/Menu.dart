import 'package:flutter/material.dart';
import 'package:sandys_food_express/screens/Menu/widgets/MenuFoodTable.dart';
import 'package:sandys_food_express/services/secureStorage.dart';

import '../../constants.dart';

class Menu extends StatefulWidget {
  static final String routeName = '/menu';
  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<Menu> {
  String name = "";
  String accessToken = "";

  @override
  void initState() {
    super.initState();
    this.loadAccessToken();
  }

  void loadAccessToken() async {
    String accessToken = await SecureStorage().readSecureData('accessToken');
    setState(() {
      this.accessToken = accessToken;
    });
  }

  void loadName() async {
    String name = await SecureStorage().readSecureData('name');
    setState(() {
      this.name = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF9F9F9),
      ),
      width: double.maxFinite,
      child: Container(
        padding: EdgeInsets.only(top: 12, left: 30, right: 30),
        child: Column(
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
                    padding: EdgeInsets.all(12),
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
                  onPressed: () {},
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 18,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: new BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    ' ',
                    style: TextStyle(fontSize: 40),
                  ),
                ),
                SizedBox(width: 6),
                Text('Select all item available in a specific date'),
              ],
            ),
            MenuFoodTable()
          ],
        ),
      ),
    );
  }
}
