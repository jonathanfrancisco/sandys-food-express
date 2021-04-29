import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:sandys_food_express/common/widgets/LoadingDialog.dart';
import 'package:sandys_food_express/common/widgets/ResponseModal.dart';
import 'package:sandys_food_express/constants.dart';
import 'package:sandys_food_express/screens/SignIn/SignIn.dart';

class SignUpForm extends StatefulWidget {
  @override
  SignUpFormState createState() {
    return SignUpFormState();
  }
}

class SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameFieldController = TextEditingController();
  final _emailFieldController = TextEditingController();
  final _addressFieldController = TextEditingController();
  final _passwordFieldController = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    _nameFieldController.dispose();
    _emailFieldController.dispose();
    _addressFieldController.dispose();
    _passwordFieldController.dispose();

    super.dispose();
  }

  void handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return LoadingDialog();
        },
      );

      try {
        var response =
            await Dio().post('http://192.168.254.104:3000/sign-up', data: {
          'name': _nameFieldController.text,
          'email': _emailFieldController.text,
          'address': _addressFieldController.text,
          'password': _passwordFieldController.text,
        });
        Navigator.of(context).pop(); // Pops loading dialog

        debugPrint(response.data.toString());
        showAnimatedDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) {
            return ResponseModal(
              type: 'SUCCESS',
              message: 'Your account has been created!\n You may now sign-in!',
              onContinueOrCancel: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/sign-in');
              },
            );
          },
        );
      } on DioError catch (e) {
        debugPrint(e.toString());
        Navigator.of(context).pop(); // Pops loading dialog
        Map<String, dynamic> responseBody = e.response?.data;
        var errorCode = responseBody['error']['code'];
        var errorMessage = responseBody['error']['message'];

        if (e.response?.statusCode == 400) {
          debugPrint(errorCode);
          debugPrint(
              errorMessage); // var errorMessage = responseBody?.error?.message;
          if (errorCode == 'USER_EMAIL_ALREADY_EXISTS') {
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
                message: 'Something weird happened.\nKeep calm and try again.',
                onContinueOrCancel: () {
                  Navigator.of(context).pop();
                },
              );
            },
          );
        }
      }
    }
  }

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
              controller: _nameFieldController,
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name is required';
                }

                return null;
              },
            ),
            SizedBox(height: 12),
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }

                return null;
              },
            ),
            SizedBox(height: 12),
            TextFormField(
              controller: _addressFieldController,
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Address is required';
                }

                return null;
              },
            ),
            SizedBox(height: 12),
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }

                return null;
              },
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
              onPressed: handleSubmit,
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
