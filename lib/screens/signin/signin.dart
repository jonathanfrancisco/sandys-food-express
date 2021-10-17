import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:provider/provider.dart';

import 'package:sandys_food_express/common/widgets/gradient-background.dart';
import 'package:sandys_food_express/common/widgets/response-modal.dart';
import 'package:sandys_food_express/common/widgets/screen-title.dart';
import 'package:sandys_food_express/common/widgets/app-header.dart';
import 'package:sandys_food_express/common/widgets/app-footer.dart';
import 'package:sandys_food_express/common/widgets/progress-hud.dart';
import 'package:sandys_food_express/constants.dart';

import 'package:sandys_food_express/screens/signin/signin-view-model.dart';

import 'package:sandys_food_express/screens/signup/signup.dart';
import 'package:sandys_food_express/screens/signin/google-signin-btn-view.dart';
import 'package:sandys_food_express/service-locator.dart';

class SignIn extends StatefulWidget {
  static final routeName = '/sign-in';
  final _formKey = GlobalKey<FormState>();
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();

  @override
  SignInState createState() => SignInState();
}

class SignInState extends State<SignIn> {
  @override
  void dispose() {
    this.widget._emailFieldController.dispose();
    this.widget._passwordFieldController.dispose();
    locator.resetLazySingleton<SignInViewModel>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignInViewModel>(
      create: (context) => locator<SignInViewModel>(),
      child: Consumer<SignInViewModel>(
        builder: (context, signInViewModel, child) => SafeArea(
          child: ProgressHUD(
            inProgress: signInViewModel.state == ViewState.Busy ? true : false,
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
                      Form(
                        autovalidateMode: AutovalidateMode.always,
                        key: this.widget._formKey,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 30,
                            horizontal: 30,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              TextFormField(
                                controller: this.widget._emailFieldController,
                                validator: (value) =>
                                    signInViewModel.isValidEmail(value),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
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
                              ),
                              SizedBox(height: 14),
                              TextFormField(
                                controller:
                                    this.widget._passwordFieldController,
                                validator: (value) =>
                                    signInViewModel.isValidPasssword(value),
                                obscureText:
                                    signInViewModel.obscurePasswordField,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  isDense: true,
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide.none,
                                  ),
                                  alignLabelWithHint: true,
                                  hintText: "Password",
                                  suffixIconConstraints: BoxConstraints(
                                    minHeight: 35,
                                    minWidth: 40,
                                  ),
                                  suffixIcon: new GestureDetector(
                                    onTap: () => signInViewModel
                                        .toggleObscurePassworField(),
                                    child: Container(
                                      padding: EdgeInsets.all(0),
                                      margin: EdgeInsets.all(0),
                                      child: Icon(
                                        signInViewModel.obscurePasswordField
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 18),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  primary: primaryColor,
                                ),
                                onPressed: () async {
                                  if (!this
                                      .widget
                                      ._formKey
                                      .currentState!
                                      .validate()) {
                                    return;
                                  }

                                  bool isSignInSuccess =
                                      await signInViewModel.signIn(
                                    this.widget._emailFieldController.text,
                                    this.widget._passwordFieldController.text,
                                  );

                                  if (isSignInSuccess) {
                                    showAnimatedDialog(
                                      barrierDismissible: true,
                                      context: context,
                                      builder: (context) {
                                        return ResponseModal(
                                          type: 'SUCCESS',
                                          message:
                                              signInViewModel.successMessage,
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
                                          message: signInViewModel.errorMessage,
                                          onContinueOrCancel: () {
                                            Navigator.of(context).pop();
                                          },
                                        );
                                      },
                                    );
                                  }
                                },
                                child: Text('Sign In'),
                              ),
                              SizedBox(height: 8),
                              GoogleSignInBtn(),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
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
