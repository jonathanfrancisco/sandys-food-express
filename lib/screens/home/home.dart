import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandys_food_express/common/widgets/progress-hud.dart';
import 'package:sandys_food_express/screens/home/home-view-model.dart';
import 'package:sandys_food_express/screens/home/widgets/app-bar-drawer-header.dart';
import 'package:sandys_food_express/screens/home/widgets/app-bar-title.dart';
import 'package:sandys_food_express/screens/home/widgets/drawer-item.dart';
import 'package:sandys_food_express/screens/menu/menu.dart';
import 'package:sandys_food_express/screens/menu/menu-view-model.dart';
import 'package:sandys_food_express/screens/orders/orders-tab-add-order-view-model.dart';
import 'package:sandys_food_express/screens/orders/orders.dart';
import 'package:sandys_food_express/screens/ordersqueue/ordersqueue.dart';
import 'package:sandys_food_express/service-locator.dart';
import '../../constants.dart';

class Home extends StatefulWidget {
  static final String routeName = '/home';
  final _homeNavigatorKey = GlobalKey<NavigatorState>();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Route _onGenerateRoute(RouteSettings settings) {
    late Widget page;
    if (settings.name == OrdersQueue.routeName) {
      page = OrdersQueue();
    }

    if (settings.name == Orders.routeName) {
      ;

      page = MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => locator.get<MenuViewModel>(),
          ),
          ChangeNotifierProvider(
            create: (_) => locator.get<OrdersTabAddOrderViewModel>(),
          )
        ],
        child: Orders(),
      );
    }

    if (settings.name == Menu.routeName) {
      page = ChangeNotifierProvider<MenuViewModel>(
        create: (context) => locator.get<MenuViewModel>(),
        child: Menu(),
      );
    }

    return MaterialPageRoute<dynamic>(
      builder: (context) {
        return page;
      },
      settings: settings,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> drawerItems = [
      {
        "icon": Icon(Icons.add),
        "title": "QUEUE",
        "to": OrdersQueue.routeName,
      },
      {
        "icon": Icon(Icons.add),
        "title": "ORDERS",
        "to": Orders.routeName,
      },
      {
        "icon": Icon(Icons.add),
        "title": "MENU",
        "to": Menu.routeName,
      },
      // {
      //   "icon": Icon(Icons.add),
      //   "title": "DRAFTS",
      //   "to": Orders.routeName,
      // },
      // {
      //   "icon": Icon(Icons.add),
      //   "title": "GROCERY LIST",
      //   "to": Orders.routeName,
      // },
      // {
      //   "icon": Icon(Icons.add),
      //   "title": "REPORTS ",
      //   "to": Orders.routeName,
      // }
    ];

    return ChangeNotifierProvider<HomeViewModel>(
      create: (context) => locator<HomeViewModel>(),
      child: WillPopScope(
        onWillPop: () async {
          // do nothing

          return false;
        },
        child: ProgressHUD(
          inProgress: false,
          child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Colors.white,
                title: AppBarTitle(),
                elevation: 0,
              ),
              drawer: Drawer(
                child: Container(
                  decoration: BoxDecoration(
                    color: accentColor,
                  ),
                  child: ListView(
                    children: [
                      AppBarDrawerHeader(),
                      ...drawerItems.map((e) {
                        return Consumer<HomeViewModel>(
                          builder: (context, homeViewModel, child) =>
                              DrawerItem(
                            icon: e['icon'],
                            title: e['title'],
                            isActive: e['title'] ==
                                homeViewModel.currentActiveDrawerItemTitle,
                            onPress: () {
                              homeViewModel
                                  .setCurrentActiveDrawerItemTitle(e['title']);
                              this
                                  .widget
                                  ._homeNavigatorKey
                                  .currentState!
                                  .pushNamed(e['to']);

                              Navigator.pop(context); // closes app drawer
                            },
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
              body: Navigator(
                key: this.widget._homeNavigatorKey,
                initialRoute: OrdersQueue.routeName,
                onGenerateRoute: _onGenerateRoute,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
