import 'package:flutter/material.dart';

class AppFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            "Sandy's Food Express 2021",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Text(
            'Designed by Joy Pangilinan',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
