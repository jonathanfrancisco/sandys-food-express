import 'package:flutter/material.dart';
import 'package:sandys_food_express/constants.dart';
import 'package:sandys_food_express/screens/orders/widgets/orders-tab.dart';
import 'package:sandys_food_express/screens/orders/widgets/deliveries-tab.dart';
import 'package:sandys_food_express/screens/orders/widgets/processed-orders-tab.dart';


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
              OrdersTab(),
              Deliveries(),
              ProcessedOrders(),
            ],
          ),
        ),
      ),
    );
  }
}
