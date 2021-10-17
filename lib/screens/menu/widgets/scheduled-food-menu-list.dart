import 'package:sandys_food_express/constants.dart';
import 'package:flutter/material.dart';

class ScheduledFoodMenuList extends StatefulWidget {
  ScheduledFoodMenuListState createState() => ScheduledFoodMenuListState();
}

class ScheduledFoodMenuListState extends State<ScheduledFoodMenuList> {
  List<bool> expansionPanelsOpenState = [false, false, false, false];

  Widget build(BuildContext context) {
    return ExpansionPanelList(
      elevation: 1,
      children: List.generate(5, (index) {
        return ExpansionPanel(
          isExpanded: expansionPanelsOpenState[0],
          canTapOnHeader: true,
          headerBuilder: (context, isOpen) {
            return Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'August 1, 2020 3:00pm',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          },
          body: Container(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Edit',
                      style: TextStyle(
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Burger',
                      style: TextStyle(),
                    ),
                    Text(
                      '89',
                      style: TextStyle(
                        color: primaryColor,
                      ),
                    ),
                    Icon(
                      Icons.remove_circle,
                      color: Colors.grey,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Burger',
                      style: TextStyle(),
                    ),
                    Text(
                      '89',
                      style: TextStyle(
                        color: primaryColor,
                      ),
                    ),
                    Icon(
                      Icons.remove_circle,
                      color: Colors.grey,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Burger',
                      style: TextStyle(),
                    ),
                    Text(
                      '89',
                      style: TextStyle(
                        color: primaryColor,
                      ),
                    ),
                    Icon(
                      Icons.remove_circle,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
      expansionCallback: (i, isOpen) {
        setState(() {
          expansionPanelsOpenState[i] = !isOpen;
        });
      },
    );
  }
}
