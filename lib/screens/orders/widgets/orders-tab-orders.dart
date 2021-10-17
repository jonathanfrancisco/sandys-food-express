import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sandys_food_express/constants.dart';
import 'package:sandys_food_express/screens/orders/widgets/orders-tab-add-order.dart';

class OrdersTabOrders extends StatelessWidget {
  static final String routeName = '/orders';

  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: actionBtnColor,
                  ),
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrdersTabAddOrder()));
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 18,
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                showBottomBorder: true,
                dividerThickness: 0.25,
                headingTextStyle: TextStyle(
                  color: tableColTextColor,
                ),
                columns: [
                  DataColumn(
                    label: Text(
                      'Code',
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Name',
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Total',
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Delivery Time',
                    ),
                  ),
                ],
                rows: List.generate(
                  20,
                  (index) {
                    return DataRow(
                      color: MaterialStateProperty.all(Colors.white),
                      cells: [
                        DataCell(
                          Text(
                            'REF12345',
                            style: TextStyle(
                              color: tableRowTextColor,
                            ),
                          ),
                        ),
                        DataCell(Text('Jonathan',
                            style: TextStyle(
                              color: tableRowTextColor,
                            ))),
                        DataCell(
                          Text(
                            '100.00',
                            style: TextStyle(
                              color: primaryColor,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(
                            '8:00 AM',
                            style: TextStyle(
                              color: tableRowTextColor,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
