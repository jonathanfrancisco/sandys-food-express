import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sandys_food_express/constants.dart';
import 'package:sandys_food_express/screens/menu/menu-view-model.dart';
import 'package:sandys_food_express/screens/menu/widgets/menu-food-table.dart';

class OrdersTabAddOrder extends StatefulWidget {
  static final String routeName = '/menu/add-order';
  @override
  OrdersTabAddOrderState createState() => OrdersTabAddOrderState();
}

class OrdersTabAddOrderState extends State<OrdersTabAddOrder> {
  final _formKey = GlobalKey<FormState>();
  final _customerNameFieldController = TextEditingController();
  final _customerAddressFieldController = TextEditingController();
  final _searchFieldController = TextEditingController();

  DateTime _scheduledDate = DateTime.now();
  TimeOfDay _scheduledTime = TimeOfDay.now();
  List<int> _selectedFoodIds = [];

  _onMenuFoodTableRowSelectToggle(int foodId) {
    setState(() {
      if (_selectedFoodIds.indexOf(foodId) == -1) {
        _selectedFoodIds.add(foodId);
      } else {
        _selectedFoodIds.remove(foodId);
      }
    });
  }

  _onMenuFoodTableRowSelectAllToggle(List<int> availableFoodIds) {
    if (_selectedFoodIds.length == availableFoodIds.length) {
      return setState(() {
        _selectedFoodIds.clear();
      });
    }

    return setState(() {
      availableFoodIds.forEach((foodId) {
        if (_selectedFoodIds.indexOf(foodId) == -1) {
          _selectedFoodIds.add(foodId);
        }
      });
    });
  }

  _selectScheduledDate(BuildContext context) async {
    final selectedScheduledDate = await showDatePicker(
      context: context,
      initialDate: _scheduledDate,
      firstDate: _scheduledDate,
      lastDate: DateTime(2100),
    );

    setState(() => _scheduledDate = selectedScheduledDate!);
  }

  _selectScheduleTime(BuildContext context) async {
    final selectedScheduledTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    setState(() => _scheduledTime = selectedScheduledTime!);
  }

  @override
  Widget build(BuildContext context) {
    MenuViewModel menuViewModel =
        Provider.of<MenuViewModel>(context, listen: false);

    Size screenSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: primaryColor,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: screenSize.width * 0.20),
                Text(
                  'Add Order',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: borderColor,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Customer Name',
                              ),
                              Text(
                                '*',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            style: TextStyle(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Customer name is required';
                              }
                              return null;
                            },
                            controller: _customerNameFieldController,
                            decoration: InputDecoration(
                              hintText: 'Customer Name',
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              Text(
                                'Delivery Date/Time',
                              ),
                              Text(
                                '*',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () => _selectScheduledDate(context),
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: borderColor, width: 1),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      DateFormat('yyyy-MM-dd')
                                          .format(_scheduledDate),
                                      style: TextStyle(
                                        color: subTextColor,
                                      ),
                                    ),
                                    SizedBox(width: 14),
                                    Icon(
                                      Icons.event,
                                      size: 16,
                                      color: subTextColor,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 10),
                              TextButton(
                                onPressed: () => _selectScheduleTime(context),
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: borderColor, width: 1),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      _scheduledTime.format(context),
                                      style: TextStyle(
                                        color: subTextColor,
                                      ),
                                    ),
                                    SizedBox(width: 14),
                                    Icon(
                                      Icons.av_timer,
                                      size: 16,
                                      color: subTextColor,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              Text(
                                'Delivery Address',
                              ),
                              Text(
                                '*',
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            style: TextStyle(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Delivery Address is required';
                              }
                              return null;
                            },
                            controller: _customerAddressFieldController,
                            decoration: InputDecoration(
                              hintText: 'Delivery Address',
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.zero,
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Text(
                          'Food Menu',
                        ),
                        Text(
                          '*',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: borderColor,
                        ),
                      ),
                      child: Column(
                        children: [
                          MenuFoodTable(
                            selectedFoodIds: _selectedFoodIds,
                            onMenuFoodTableRowSelectAllToggle:
                                _onMenuFoodTableRowSelectAllToggle,
                            onMenuFoodTableRowSelectToggle:
                                _onMenuFoodTableRowSelectToggle,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
