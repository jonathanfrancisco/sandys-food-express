import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResponseModal extends StatelessWidget {
  final String type;
  final String? message;
  final Function onContinueOrCancel;

  ResponseModal(
      {required this.type,
      required this.message,
      required this.onContinueOrCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            type == 'SUCCESS'
                ? 'assets/images/success-response.svg'
                : 'assets/images/error-response.svg',
            // width: 20,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            type == 'SUCCESS' ? 'Woo hoo!' : 'Uh oh.',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.yellow[700],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            this.message!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
      actions: [
        Container(
          padding: EdgeInsets.only(
            left: 12,
            right: 12,
            top: 60,
            bottom: 14,
          ),
          width: double.maxFinite,
          // alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 20,
                  ),
                  backgroundColor:
                      type == 'SUCCESS' ? Colors.yellow[700] : Colors.red[600],
                  primary: Colors.white,
                ),
                child: Text(
                  type == 'SUCCESS' ? 'CONTINUE' : 'TRY AGAIN',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () async {
                  onContinueOrCancel();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
