import 'package:flutter/material.dart';
import 'package:sandys_food_express/constants.dart';

class QueueOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.85,
      decoration: BoxDecoration(
        color: accentColor,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order # ABCDEF12344',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '100',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Burger Mcdo'),
                    Text('10:00 PM'),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFFEAEAEA),
                            ),
                          ),
                          child: Text(
                            '2x',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text('Mcdo Korean Burger'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Color(0xFFEAEAEA),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextButton(
                    child: Text(
                      'Done',
                      style: TextStyle(
                        color: primaryColor,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
                Expanded(
                  child: TextButton(
                    child: Text(
                      'Cancel Order',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE11A1A),
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
