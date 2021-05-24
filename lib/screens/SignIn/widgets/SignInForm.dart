import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:sandys_food_express/common/widgets/LoadingDialog.dart';
import 'package:sandys_food_express/common/widgets/ResponseModal.dart';
import 'package:sandys_food_express/constants.dart';
import 'package:sandys_food_express/services/secureStorage.dart';

class SignInForm extends StatefulWidget {
  @override
  SignInFormState createState() {
    return SignInFormState();
  }
}

class SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: _emailFieldController,
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
            ),
            SizedBox(height: 14),
            TextFormField(
              controller: _passwordFieldController,
              obscureText: _obscureText,
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
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                primary: primaryColor,
                padding: EdgeInsets.all(14),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return LoadingDialog();
                    },
                  );

                  try {
                    var httpResponse =
                        await Dio().post('$apiHostEndpoint/sign-in', data: {
                      'email': _emailFieldController.text,
                      'password': _passwordFieldController.text,
                    });
                    var httpResponseBody = httpResponse.data;

                    String name = httpResponseBody['data']['name'];
                    String accessToken =
                        httpResponseBody['data']['accessToken'];

                    await SecureStorage().writeSecureData('name', name);
                    await SecureStorage()
                        .writeSecureData('accessToken', accessToken);

                    Navigator.of(context).pop(); // Pops loading dialog

                    showAnimatedDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (context) {
                        return ResponseModal(
                          type: 'SUCCESS',
                          message: "Welcome $name Sandy's Food Express!",
                          onContinueOrCancel: () {
                            Navigator.of(context).pop();
                            Navigator.pushReplacementNamed(context, '/home');
                          },
                        );
                      },
                    );
                  } on DioError catch (e) {
                    Navigator.of(context).pop(); // Pops loading dialog
                    var httpResponseBody = e.response?.data;

                    if (httpResponseBody == null) {
                      showAnimatedDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (context) {
                          return ResponseModal(
                            type: 'ERROR',
                            message:
                                'Something weird happened.\nKeep calm and try again.',
                            onContinueOrCancel: () {
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      );
                    }
                    String errorCode = httpResponseBody['error']['code'];
                    String errorMessage = httpResponseBody['error']['message'];

                    if (e.response?.statusCode == 401) {
                      if (errorCode == 'INVALID_USERNAME_OR_PASSWORD') {
                        showAnimatedDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (context) {
                            return ResponseModal(
                              type: 'ERROR',
                              message: errorMessage,
                              onContinueOrCancel: () {
                                Navigator.of(context).pop();
                              },
                            );
                          },
                        );
                      }
                    } else {
                      showAnimatedDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (context) {
                          return ResponseModal(
                            type: 'ERROR',
                            message:
                                'Something weird happened.\nKeep calm and try again.',
                            onContinueOrCancel: () {
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      );
                    }
                  }
                }
              },
              child: Text('Sign In'),
            ),
            SizedBox(height: 12),
            OutlinedButton(
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
            )
          ],
        ),
      ),
    );
  }
}
