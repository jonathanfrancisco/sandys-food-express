import 'package:flutter/material.dart';

import 'package:sandys_food_express/common/widgets/GradientBackground.dart';
import 'package:sandys_food_express/common/widgets/ScreenTitle.dart';
import 'package:sandys_food_express/common/widgets/AppHeader.dart';
import 'package:sandys_food_express/common/widgets/AppFooter.dart';
import 'package:sandys_food_express/screens/SignIn/widgets/SignInForm.dart';

import 'package:sandys_food_express/screens/SignUp/SignUp.dart';

class SignIn extends StatelessWidget {
  static final routeName = '/sign-in';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GradientBackground(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppHeader(),
                ScreenTitle(
                  title: 'Sign In',
                  subtitle: 'New user?',
                  subtitleAction: ' Create an account',
                  subtitleActionOnTap: (context) {
                    Navigator.pushNamed(context, SignUp.routeName);
                  },
                ),
                SignInForm(),
                AppFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
