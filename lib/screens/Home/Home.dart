import 'package:flutter/material.dart';
import 'package:sandys_food_express/screens/Home/widgets/AppBarDrawerHeader.dart';
import 'package:sandys_food_express/screens/Home/widgets/AppBarTitle.dart';
import 'package:sandys_food_express/screens/Menu/Menu.dart';
import 'package:sandys_food_express/screens/OrdersQueue/OrdersQueue.dart';
import '../../constants.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _homeNavigatorKey = GlobalKey<NavigatorState>();
  String currentActiveDrawerItemTitle = 'QUEUE';

  Route _onGenerateRoute(RouteSettings settings) {
    debugPrint("I was here");
    late Widget page;

    if (settings.name == OrdersQueue.routeName) {
      page = OrdersQueue();
    }

    if (settings.name == Menu.routeName) {
      page = Menu();
    }

    return MaterialPageRoute<dynamic>(
      builder: (context) {
        return page;
      },
      settings: settings,
    );
  }

  Widget _buildDrawerItemWidget(
      Icon icon, String title, bool isActive, Function onPress) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(0),
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        backgroundColor: isActive ? primaryColor : accentColor,
        primary: isActive ? Colors.white : primaryColor,
      ),
      child: Row(
        children: [
          icon,
          SizedBox(width: 10),
          Text(title),
        ],
      ),
      onPressed: () {
        onPress();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<DrawerItem> drawerItems = [
      DrawerItem(
          icon: Icon(Icons.add), title: 'QUEUE', to: OrdersQueue.routeName),
      DrawerItem(icon: Icon(Icons.add), title: 'MENU', to: Menu.routeName),
    ].map((e) {
      if (currentActiveDrawerItemTitle == e.title) {
        e.isActive = true;
        return e;
      }
      return e;
    }).toList();

    return SafeArea(
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
                  return _buildDrawerItemWidget(e.icon, e.title, e.isActive,
                      () {
                    debugPrint("Button pressed");
                    _homeNavigatorKey.currentState!.pushNamed(e.to);
                    setState(() {
                      currentActiveDrawerItemTitle = e.title;
                    });
                    Navigator.pop(context); // closes app drawer
                  });
                }).toList(),
              ],
            ),
          ),
        ),
        body: Navigator(
          key: _homeNavigatorKey,
          initialRoute: OrdersQueue.routeName,
          onGenerateRoute: _onGenerateRoute,
        ),
      ),
    );
  }
}

class DrawerItem {
  final Icon _icon;
  final String _title;
  final String _to;
  bool _isActive;

  DrawerItem({
    required Icon icon,
    required String title,
    required String to,
    bool isActive = false,
  })  : _title = title,
        _icon = icon,
        _isActive = isActive,
        _to = to;

  String get title {
    return _title;
  }

  Icon get icon {
    return _icon;
  }

  bool get isActive {
    return _isActive;
  }

  String get to {
    return _to;
  }

  set isActive(bool isActive) {
    this._isActive = isActive;
  }
}
