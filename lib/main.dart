import 'package:flutter/material.dart';
import 'package:sandys_food_express/service-locator.dart';
import 'package:sandys_food_express/app.dart';

void main() {
  setupLocator();
  runApp(App());
}
