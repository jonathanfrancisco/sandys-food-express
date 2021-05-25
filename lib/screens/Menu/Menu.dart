import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

import 'package:sandys_food_express/screens/Menu/widgets/MenuFoodTableInfo.dart';
import 'package:sandys_food_express/screens/Menu/widgets/MenuFoodTable.dart';
import 'package:sandys_food_express/screens/Menu/widgets/AddFoodModal.dart';

import 'package:sandys_food_express/services/secureStorage.dart';

import 'package:sandys_food_express/constants.dart';

class Menu extends StatefulWidget {
  static final String routeName = '/menu';
  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<Menu> {
  late Dio _dioClient;
  late Future<List<dynamic>> _futureFoods;

  @override
  void initState() {
    super.initState();
    this._dioClient = Dio();
    this._futureFoods = this._getFoods();
  }

  Future<List<dynamic>> _getFoods() async {
    await Future.delayed(Duration(seconds: 2));
    String accessToken = await SecureStorage().readSecureData('accessToken');
    _dioClient.options.headers['Authorization'] = 'Bearer $accessToken';
    var httpResponse = await this._dioClient.get('$apiHostEndpoint/menu/foods');
    var httpResponseBody = httpResponse.data;

    return httpResponseBody['data'];
  }

  void _onAddFood() {
    setState(() {
      this._futureFoods = this._getFoods();
    });
  }

  void _onDeleteFood(int id) async {
    String accessToken = await SecureStorage().readSecureData('accessToken');
    _dioClient.options.headers['Authorization'] = 'Bearer $accessToken';
    var httpResponse =
        await this._dioClient.delete('$apiHostEndpoint/menu/foods/$id');
    var httpResponseBody = httpResponse.data;

    setState(() {
      this._futureFoods = this._getFoods();
    });
  }

  Future<void> _onRefresh() async {
    setState(() {
      this._futureFoods = this._getFoods();
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
                  onPressed: () {
                    showAnimatedDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AddFoodModal(onAddFood: _onAddFood);
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
            ),
            SizedBox(height: 8),
            MenuFoodTableInfo(),
            MenuFoodTable(
              futureFoods: _futureFoods,
              onRefresh: _onRefresh,
              onDeleteFood: _onDeleteFood,
            ),
            SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
