import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:provider/provider.dart';
import 'package:sandys_food_express/common/widgets/loading_dialog.dart';
import 'package:sandys_food_express/common/widgets/response_modal.dart';
import 'package:sandys_food_express/common/widgets/progress_hud.dart';
import 'package:sandys_food_express/constants.dart';

import 'package:sandys_food_express/common/widgets/gradient_background.dart';
import 'package:sandys_food_express/common/widgets/screen_title.dart';
import 'package:sandys_food_express/common/widgets/app_header.dart';
import 'package:sandys_food_express/common/widgets/app_footer.dart';
import 'package:sandys_food_express/screens/signup/signup_view_model.dart';
import 'package:sandys_food_express/service_locator.dart';

class SignUp extends StatefulWidget {
  static final routeName = '/sign-up';
  final _formKey = GlobalKey<FormState>();
  final _nameFieldController = TextEditingController();
  final _emailFieldController = TextEditingController();
  final _addressFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  @override
  void dispose() {
    this.widget._nameFieldController.dispose();
    this.widget._emailFieldController.dispose();
    this.widget._addressFieldController.dispose();
    this.widget._passwordFieldController.dispose();
    locator.resetLazySingleton<SignUpViewModel>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider<SignUpViewModel>(
        create: (context) => locator<SignUpViewModel>(),
        child: Consumer<SignUpViewModel>(
          builder: (context, signUpViewModel, child) => ProgressHUD(
            inProgress: false,
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
                      Form(
                        key: this.widget._formKey,
                        autovalidateMode: AutovalidateMode.always,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 30, horizontal: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              TextFormField(
                                controller: this.widget._nameFieldController,
                                style: TextStyle(fontSize: 14),
                                decoration: InputDecoration(
                                  isDense: true,
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide.none,
                                  ),
                                  alignLabelWithHint: true,
                                  hintText: "Name",
                                ),
                                validator: (value) =>
                                    signUpViewModel.isValidName(value),
                              ),
                              SizedBox(height: 12),
                              TextFormField(
                                controller: this.widget._emailFieldController,
                                style: TextStyle(fontSize: 14),
                                decoration: InputDecoration(
                                  isDense: true,
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide.none,
                                  ),
                                  alignLabelWithHint: true,
                                  hintText: "Email",
                                ),
                                validator: (value) =>
                                    signUpViewModel.isValidEmail(value),
                              ),
                              SizedBox(height: 12),
                              TextFormField(
                                controller: this.widget._addressFieldController,
                                style: TextStyle(fontSize: 14),
                                decoration: InputDecoration(
                                  isDense: true,
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide.none,
                                  ),
                                  alignLabelWithHint: true,
                                  hintText: "Address",
                                ),
                                validator: (value) =>
                                    signUpViewModel.isValidAddress(value),
                              ),
                              SizedBox(height: 12),
                              TextFormField(
                                controller:
                                    this.widget._passwordFieldController,
                                obscureText:
                                    signUpViewModel.obscurePasswordField,
                                style: TextStyle(fontSize: 14),
                                decoration: InputDecoration(
                                  isDense: true,
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide.none,
                                  ),
                                  alignLabelWithHint: true,
                                  hintText: "Password",
                                  suffixIcon: new GestureDetector(
                                    onTap: () {
                                      signUpViewModel
                                          .toggleObscurePasswordField();
                                    },
                                    child: Icon(
                                      signUpViewModel.obscurePasswordField
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                validator: (value) =>
                                    signUpViewModel.isValidPassword(value),
                              ),
                              SizedBox(height: 12),
                              Column(
                                children: [
                                  Text('By creating an account, I agree to'),
                                  Text(
                                    'Terms and Conditions',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  primary: primaryColor,
                                  padding: EdgeInsets.all(12),
                                ),
                                onPressed: () async {
                                  if (!this
                                      .widget
                                      ._formKey
                                      .currentState!
                                      .validate()) {
                                    return;
                                  }

                                  bool isSignUpSuccess =
                                      await signUpViewModel.signUp(
                                    this.widget._nameFieldController.text,
                                    this.widget._emailFieldController.text,
                                    this.widget._addressFieldController.text,
                                    this.widget._passwordFieldController.text,
                                  );

                                  if (isSignUpSuccess) {
                                    showAnimatedDialog(
                                      barrierDismissible: true,
                                      context: context,
                                      builder: (context) {
                                        return ResponseModal(
                                          type: 'SUCCESS',
                                          message:
                                              signUpViewModel.successMessage,
                                          onContinueOrCancel: () {
                                            Navigator.pushNamed(
                                                context, '/home');
                                          },
                                        );
                                      },
                                    );
                                  } else {
                                    showAnimatedDialog(
                                      barrierDismissible: true,
                                      context: context,
                                      builder: (context) {
                                        return ResponseModal(
                                          type: 'ERROR',
                                          message: signUpViewModel.errorMessage,
                                          onContinueOrCancel: () {
                                            Navigator.of(context).pop();
                                          },
                                        );
                                      },
                                    );
                                  }
                                },
                                child: Text('Sign Up'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      AppFooter(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
