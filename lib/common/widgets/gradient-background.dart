import 'package:flutter/material.dart';
import 'package:sandys_food_express/constants.dart';

class GradientBackground extends StatelessWidget {
  Widget? _child;

  GradientBackground({required Widget child}) {
    this._child = child;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.yellow.shade300,
            primaryColor,
          ],
        ),
      ),
      child: this._child,
    );
  }
}
