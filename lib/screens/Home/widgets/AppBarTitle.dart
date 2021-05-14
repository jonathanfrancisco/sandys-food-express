import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
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
    );
  }
}
