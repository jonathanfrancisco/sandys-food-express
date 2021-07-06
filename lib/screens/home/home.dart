import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandys_food_express/common/widgets/progress_hud.dart';
import 'package:sandys_food_express/screens/home/home_view_model.dart';
import 'package:sandys_food_express/screens/home/widgets/app_bar_drawer_header.dart';
import 'package:sandys_food_express/screens/home/widgets/app_bar_title.dart';
import 'package:sandys_food_express/screens/home/widgets/drawer_item.dart';
import 'package:sandys_food_express/screens/menu/menu.dart';
import 'package:sandys_food_express/screens/menu/menu_view_model.dart';
import 'package:sandys_food_express/screens/ordersqueue/ordersqueue.dart';
import 'package:sandys_food_express/service_locator.dart';
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

    if (settings.name == Menu.routeName) {
      // page = Menu();
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
        "title": "MENU",
        "to": Menu.routeName,
      }
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
                            to: e['to'],
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