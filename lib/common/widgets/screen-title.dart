import 'package:flutter/material.dart';
import 'package:sandys_food_express/constants.dart';

class ScreenTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final String subtitleAction;
  final Function subtitleActionOnTap;

  ScreenTitle(
      {required this.title,
      required this.subtitle,
      required this.subtitleAction,
      required this.subtitleActionOnTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            GestureDetector(
              onTap: () => subtitleActionOnTap(context),
              child: Text(
                subtitleAction,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
