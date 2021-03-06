import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sandys_food_express/constants.dart';
import 'package:sandys_food_express/screens/orders/orders-tab-add-order-view-model.dart';
import 'package:sandys_food_express/screens/orders/widgets/added-food-order.dart';
import 'package:sandys_food_express/screens/orders/widgets/order-menu-table.dart';
import 'package:sandys_food_express/screens/orders/widgets/order-total-summary.dart';

class OrdersTabAddOrder extends StatefulWidget {
  static final String routeName = '/menu/add-order';
  @override
  OrdersTabAddOrderState createState() => OrdersTabAddOrderState();
}

class OrdersTabAddOrderState extends State<OrdersTabAddOrder> {
  final _formKey = GlobalKey<FormState>();
  final _customerNameFieldController = TextEditingController();
  final _customerAddressFieldController = TextEditingController();

  DateTime _scheduledDate = DateTime.now();
  TimeOfDay _scheduledTime = TimeOfDay.now();

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
                              contentPadding: EdgeInsets.all(10),
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
                              contentPadding: EdgeInsets.all(10),
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
                    OrderMenuTable(),
                    SizedBox(height: 15),
                    Consumer<OrdersTabAddOrderViewModel>(
                        builder: (context, ordersTabAddOrderViewModel, child) {
                      List<Widget> addedOrders =
                          ordersTabAddOrderViewModel.orders
                              .map((e) => AddedFoodOrder(
                                    id: e['id'],
                                    name: e['name'],
                                    picture: e['picture'],
                                    price: e['price'],
                                    quantity: e['quantity'],
                                    onIncrease: ordersTabAddOrderViewModel
                                        .onOrderQuantityIncrease,
                                    onDecrease: ordersTabAddOrderViewModel
                                        .onOrderQuantityDecrease,
                                    onRemove: ordersTabAddOrderViewModel
                                        .onOrderRemove,
                                  ))
                              .toList();
                      return Column(
                        children: addedOrders,
                      );
                    }),
                    Consumer<OrdersTabAddOrderViewModel>(
                        builder: (context, ordersTabAddOrderViewModel, child) {
                      String subTotal = "0.00";

                      if (ordersTabAddOrderViewModel.orders.length > 0) {
                        ordersTabAddOrderViewModel.orders.forEach((o) {
                          double wtf = o['quantity'].toDouble();
                          subTotal = (double.parse(subTotal) +
                                  double.parse(o['price']) * wtf)
                              .toString();
                        });
                      }

                      String deliveryFee = "88.00";
                      String total =
                          (double.parse(subTotal) + double.parse(deliveryFee))
                              .toString();

                      return OrderTotalSummary(
                        subTotal: subTotal,
                        deliveryFee: deliveryFee,
                        total: total,
                      );
                    })
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(0),
                          bottom: Radius.circular(0),
                        ),
                      ),
                    ),
                    child: Text(
                      'Add',
                      style: TextStyle(
                        // fontSize: 16,
                        color: accentColor,
                      ),
                    ),
                    onPressed: () {},
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      side: BorderSide(width: 1, color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(0),
                          bottom: Radius.circular(0),
                        ),
                      ),
                    ),
                    child: Text(
                      'Draft',
                      style: TextStyle(
                        color: subTextColor,
                      ),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
