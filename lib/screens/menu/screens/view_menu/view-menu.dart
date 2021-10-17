import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sandys_food_express/constants.dart';
import 'package:sandys_food_express/screens/menu/widgets/scheduled-food-menu-list.dart';

class ViewMenu extends StatefulWidget {
  ViewMenuState createState() => ViewMenuState();
}

class ViewMenuState extends State<ViewMenu> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 10, left: 20, right: 20),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: primaryColor,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: screenSize.width * 0.185),
                Text(
                  'Food Menu',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Today',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 20,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.more_horiz),
                  onPressed: () {},
                ),
              ],
            ),
            Container(
              height: 400,
              child: GridView.count(
                scrollDirection: Axis.horizontal,
                mainAxisSpacing: 25,
                crossAxisSpacing: 25,
                crossAxisCount: 2,
                children: List.generate(
                  10,
                  (index) {
                    return Container(
                      width: 230,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 7,
                            child: Container(
                              width: double.infinity,
                              child: Image.network(
                                'https://images.unsplash.com/photo-1596797038530-2c107229654b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=675&q=80',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Kare Kare',
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '70.00',
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
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
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ViewMenu()));
                  },
                  child: Text(
                    'Recents',
                    style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  'Scheduled Food Menu',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ScheduledFoodMenuList(),
          ],
        ),
      ),
    );
  }
}
