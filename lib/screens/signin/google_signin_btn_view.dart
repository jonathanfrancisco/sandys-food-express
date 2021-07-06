import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GoogleSignInBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.all(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/google_logo.svg',
            width: 20,
          ),
          SizedBox(
            width: 3,
          ),
          Text(
            'Continue with Google',
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
      onPressed: () {},
    );
  }
}
