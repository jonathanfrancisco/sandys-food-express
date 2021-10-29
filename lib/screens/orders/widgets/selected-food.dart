import 'package:flutter/material.dart';
import 'package:sandys_food_express/models/Food.dart';

class SelectedFood extends StatelessWidget {
  final Food food;
  final int quantity;

  SelectedFood({required this.food, this.quantity = 1});

  Widget build(BuildContext context) {
    return Text('Hello World');
  }
}
