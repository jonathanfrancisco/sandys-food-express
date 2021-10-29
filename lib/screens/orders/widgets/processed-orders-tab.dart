import 'package:flutter/material.dart';
import 'package:sandys_food_express/constants.dart';

class ProcessedOrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
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
                      'Date Processed',
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
