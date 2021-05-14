import 'package:flutter/material.dart';

import 'package:sandys_food_express/screens/SignUp/widgets/SignUpForm.dart';

import 'package:sandys_food_express/common/widgets/GradientBackground.dart';
import 'package:sandys_food_express/common/widgets/ScreenTitle.dart';
import 'package:sandys_food_express/common/widgets/AppHeader.dart';
import 'package:sandys_food_express/common/widgets/AppFooter.dart';

class SignUp extends StatelessWidget {
  static final routeName = '/sign-up';

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
                  title: 'Sign up',
                  subtitle: 'Already have an account?',
                  subtitleAction: ' Sign in',
                  subtitleActionOnTap: (context) {
                    Navigator.pop(context);
                  },
                ),
                SignUpForm(),
                AppFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
