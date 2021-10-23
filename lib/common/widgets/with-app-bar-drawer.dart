import 'package:flutter/material.dart';
import 'package:sandys_food_express/constants.dart';

class DrawerItem {
  final String _title;
  final Icon _icon;
  bool _isActive;
  final String _to;

  DrawerItem(
      {required String title,
      required Icon icon,
      bool isActive = false,
      required String to})
      : _title = title,
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

  set isActive(bool isActive) {
    this._isActive = isActive;
  }

  String get to {
    return _to;
  }
}

class WithAppBarDrawer extends StatelessWidget {
  final Widget _body;
  final List<DrawerItem> _drawerItems;

  WithAppBarDrawer(
      {required Widget body, required List<DrawerItem> drawerItems})
      : _body = body,
        _drawerItems = drawerItems;

  Widget buildDrawerItem(
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
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Row(
            children: [
              SizedBox(
                width: size.width * 0.18,
              ),
              new Container(
                child: Image.asset(
                  'assets/images/sandys_food_express_title.png',
                  width: 130,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
        drawer: Drawer(
          child: Container(
            decoration: BoxDecoration(
              color: accentColor,
            ),
            child: ListView(
              children: [
                DrawerHeader(
                  child: Text("Sandy's Food Express"),
                ),
                ..._drawerItems.map((e) {
                  return buildDrawerItem(e.icon, e.title, e.isActive, () {
                    Navigator.pushNamed(context, e.to);
                  });
                }).toList()
              ],
            ),
          ),
        ),
        body: this._body,
      ),
    );
  }
}
