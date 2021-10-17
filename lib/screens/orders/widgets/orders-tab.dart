import 'package:flutter/material.dart';
import 'package:sandys_food_express/constants.dart';

import 'package:sandys_food_express/screens/orders/widgets/orders-tab-add-order.dart';
import 'package:sandys_food_express/screens/orders/widgets/orders-tab-orders.dart';

class OrdersTab extends StatefulWidget {
  @override
  OrdersTabState createState() => OrdersTabState();
}

class OrdersTabState extends State<OrdersTab> {
  final _ordersTabNavigatorKey = GlobalKey<NavigatorState>();

  Route _onGenerateRoute(RouteSettings routeSettings) {
    late Widget page;

    if (routeSettings.name == OrdersTabOrders.routeName) {
      page = OrdersTabOrders();
    }

    if (routeSettings.name == OrdersTabAddOrder.routeName) {
      page = OrdersTabAddOrder();
    }

    return MaterialPageRoute(
      builder: (context) {
        return page;
      },
      settings: routeSettings,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Navigator(
      key: this._ordersTabNavigatorKey,
      initialRoute: OrdersTabOrders.routeName,
      onGenerateRoute: _onGenerateRoute,
    );
  }
}
