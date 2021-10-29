import 'package:flutter/material.dart';
import 'package:sandys_food_express/constants.dart';
import 'package:shimmer/shimmer.dart';

class MenuFoodTableHeaderLoading extends StatelessWidget {
  @override
  Widget build(BuildContext buildContext) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Shimmer.fromColors(
              baseColor: accentColor,
              highlightColor: secondaryColor,
              enabled: true,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 60,
                    height: 16.0,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
