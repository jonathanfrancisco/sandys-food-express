import 'package:flutter/material.dart';
import 'package:sandys_food_express/common/widgets/gradient-background.dart';
import 'package:sandys_food_express/screens/ordersqueue/widgets/queued-order.dart';
import 'package:sandys_food_express/services/secure-storage.dart';

class OrdersQueue extends StatefulWidget {
  static final String routeName = '/orders-queue';

  @override
  OrdersQueueState createState() => OrdersQueueState();
}

class OrdersQueueState extends State<OrdersQueue> {
  String name = "";
  String accessToken = "";

  @override
  void initState() {
    super.initState();
    this.loadAccessToken();
  }

  void loadAccessToken() async {
    String accessToken = await SecureStorage().readSecureData('accessToken');
    setState(() {
      this.accessToken = accessToken;
    });
  }

  void loadName() async {
    String name = await SecureStorage().readSecureData('name');
    setState(() {
      this.name = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Container(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                'Orders Queue',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              QueueOrder(),
              SizedBox(height: 20),
              QueueOrder(),
              SizedBox(height: 20),
              QueueOrder(),
              SizedBox(height: 20),
              QueueOrder(),
              SizedBox(height: 20),
              QueueOrder(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
