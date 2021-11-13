import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sandys_food_express/constants.dart';
import 'package:sandys_food_express/models/Food.dart';

class AddedFoodOrder extends StatefulWidget {
  final int _id;
  final String _name;
  final String _picture;
  final String _price;
  final int _quantity;
  final Function _onIncrease;
  final Function _onDecrease;
  final Function _onRemove;

  AddedFoodOrder({
    required int id,
    required String name,
    required String picture,
    required String price,
    required int quantity,
    required Function onIncrease,
    required Function onDecrease,
    required Function onRemove,
  })  : _id = id,
        _name = name,
        _picture = picture,
        _price = price,
        _quantity = quantity,
        _onIncrease = onIncrease,
        _onDecrease = onDecrease,
        _onRemove = onRemove;
  AddedFoodOrderState createState() => AddedFoodOrderState();
}

class AddedFoodOrderState extends State<AddedFoodOrder> {
  final quantityFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    quantityFieldController.text = this.widget._quantity.toString();
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Image.network(
            this.widget._picture,
            fit: BoxFit.cover,
            height: 85,
            width: 85,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(this.widget._name),
                  Text(
                    this.widget._price,
                    style: TextStyle(color: primaryColor),
                  ),
                  Container(
                    width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: primaryColor),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: quantityFieldController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            style: TextStyle(),
                            decoration: InputDecoration(
                              hintText: 'Quantity',
                              contentPadding: const EdgeInsets.all(4),
                              isDense: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        Column(children: [
                          IconButton(
                            icon: Icon(Icons.arrow_drop_up_outlined),
                            iconSize: 14,
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            onPressed: () =>
                                this.widget._onIncrease(this.widget._id),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_drop_down_outlined),
                            iconSize: 14,
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            onPressed: () =>
                                this.widget._onDecrease(this.widget._id),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.remove_circle),
            color: disabledColor,
            onPressed: () => this.widget._onRemove(this.widget._id),
          ),
        ],
      ),
    );
  }
}
