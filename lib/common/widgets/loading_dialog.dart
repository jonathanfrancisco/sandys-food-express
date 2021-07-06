import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: new Row(
          children: [
            new CircularProgressIndicator(),
            SizedBox(width: 10),
            new Text("Loading"),
          ],
        ),
      ),
    );
  }
}
