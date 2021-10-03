import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sandys_food_express/constants.dart';

class Main extends StatefulWidget {
  @override
  MainState createState() => MainState();
}

class MainState extends State<Main> {
  final _formKey = GlobalKey<FormState>();
  final _customerNameFieldController = TextEditingController();
  DateTime _scheduledDate = DateTime.now();
  TimeOfDay _scheduledTime = TimeOfDay.now();
  final _searchFieldController = TextEditingController();

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
    return Container(
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
              SizedBox(width: screenSize.width * 0.25),
              Text(
                'Add Order',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
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
                                  side:
                                      BorderSide(color: borderColor, width: 1),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    DateFormat('yyyy-MM-dd')
                                        .format(_scheduledDate),
                                    style: TextStyle(
                                      fontSize: 18,
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
                                  side:
                                      BorderSide(color: borderColor, width: 1),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    _scheduledTime.format(context),
                                    style: TextStyle(
                                      fontSize: 18,
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Delivery Address is required';
                            }
                            return null;
                          },
                          controller: _customerNameFieldController,
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
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: borderColor,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                activeColor: primaryColor,
                                value: false,
                                onChanged: (bool? value) {},
                              ),
                              Text(
                                '8 items',
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: TextField(
                            controller: _searchFieldController,
                            decoration: new InputDecoration(
                              suffixIcon:
                                  Icon(Icons.search, color: Colors.grey),
                              isDense: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: borderColor, width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: borderColor, width: 1.0),
                              ),
                              hintText: 'Search here',
                            ),
                            onChanged: (String query) {},
                          ),
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
    );
  }
}

class Deliveries extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Hello World');
  }
}

class ProcessedOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Hello World');
  }
}

class Orders extends StatelessWidget {
  static final routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
          flexibleSpace: SafeArea(
            child: TabBar(
              labelColor: primaryColor,
              unselectedLabelColor: Colors.black,
              indicatorColor: primaryColor,
              tabs: [
                Tab(text: 'Orders'),
                Tab(text: 'Deliveries'),
                Tab(text: 'Processed Orders'),
              ],
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: TabBarView(
            children: [
              Main(),
              Deliveries(),
              ProcessedOrders(),
            ],
          ),
        ),
      ),
    );
  }
}
