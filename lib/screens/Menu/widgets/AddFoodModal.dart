import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sandys_food_express/common/widgets/LoadingDialog.dart';
import 'package:sandys_food_express/common/widgets/ResponseModal.dart';
import 'package:sandys_food_express/services/secureStorage.dart';

import '../../../constants.dart';

class AddFoodModal extends StatefulWidget {
  final Function _onAddFood;

  AddFoodModal({required onAddFood}) : _onAddFood = onAddFood;

  @override
  AddFoodModalState createState() => AddFoodModalState();
}

class AddFoodModalState extends State<AddFoodModal> {
  late Dio dioClient;
  final _formKey = GlobalKey<FormState>();
  final _nameFieldController = TextEditingController();
  final _priceFieldController = TextEditingController();
  final _imagePicker = ImagePicker();
  var _foodImage;

  @override
  void initState() {
    super.initState();
    this.dioClient = Dio();
  }

  Future _getImageViaGallery() async {
    final pickedFile = await _imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _foodImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future _getImageViaCamera() async {
    final pickedFile = await _imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _foodImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _showImagePicker() async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        _getImageViaGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _getImageViaCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<String> _uploadFoodPictureToS3(
      String filename, String filePath) async {
    String accessToken = await SecureStorage().readSecureData('accessToken');
    dioClient.options.headers['Authorization'] = 'Bearer $accessToken';

    var generateUploadUrlHttpResponse = await dioClient.post(
        '$apiHostEndpoint/menu/foods/upload-url',
        data: {'filename': filename});
    var generateUploadUrlHttpResponseBody = generateUploadUrlHttpResponse.data;

    String s3UploadUrl = generateUploadUrlHttpResponseBody['data']['url'];
    FormData s3UploadFormData = FormData.fromMap({
      "key": generateUploadUrlHttpResponseBody['data']['fields']['key'],
      "bucket": generateUploadUrlHttpResponseBody['data']['fields']['bucket'],
      "X-Amz-Algorithm": generateUploadUrlHttpResponseBody['data']['fields']
          ['X-Amz-Algorithm'],
      "X-Amz-Credential": generateUploadUrlHttpResponseBody['data']['fields']
          ['X-Amz-Credential'],
      "X-Amz-Date": generateUploadUrlHttpResponseBody['data']['fields']
          ['X-Amz-Date'],
      "Policy": generateUploadUrlHttpResponseBody['data']['fields']['Policy'],
      "X-Amz-Signature": generateUploadUrlHttpResponseBody['data']['fields']
          ['X-Amz-Signature'],
      "Content-Type": generateUploadUrlHttpResponseBody['data']['fields']
          ['Content-Type'],
      "file": await MultipartFile.fromFile(filePath, filename: filename),
    });

    dioClient.options.headers['Authorization'] = '';
    var uploadToS3HttpResponse =
        await dioClient.post(s3UploadUrl, data: s3UploadFormData);
    var uploadToS3HttpResponseStatus = uploadToS3HttpResponse
        .data; // TODO:  check status and throw error if failed?

    return generateUploadUrlHttpResponseBody['data']['fields']['key'];
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return LoadingDialog();
        },
      );

      try {
        String foodImagePath = _foodImage?.path;
        String? foodImageFileName = _foodImage?.path.split('/').last;

        String uploadedFoodPictureS3Key = await _uploadFoodPictureToS3(
            foodImageFileName as String, foodImagePath);

        String accessToken =
            await SecureStorage().readSecureData('accessToken');
        dioClient.options.headers['Authorization'] = 'Bearer $accessToken';
        String foodName = _nameFieldController.text;
        double foodPrice = double.parse(_priceFieldController.text);
        var addFoodHttpResponse = await this
            .dioClient
            .post('$apiHostEndpoint/menu/foods', data: {
          'name': foodName,
          'price': foodPrice,
          'picture': uploadedFoodPictureS3Key
        });
        var addFoodHttpResponseBody = addFoodHttpResponse.data;
        var addFoodHttpResponseStatus = addFoodHttpResponse.statusCode;

        Navigator.of(context).pop(); // Pops loading dialog

        if (addFoodHttpResponseStatus == 201) {
          await showAnimatedDialog(
            barrierDismissible: true,
            context: context,
            builder: (context) {
              return ResponseModal(
                type: 'SUCCESS',
                message:
                    'You have successfully added ${addFoodHttpResponseBody["data"]["name"]}',
                onContinueOrCancel: () {
                  Navigator.of(context).pop(); // pop success add modal
                  Navigator.of(context).pop(); // pop add food modal
                },
              );
            },
          );
          this.widget._onAddFood();
        }
      } on DioError catch (e) {
        debugPrint(e.toString());
        Navigator.of(context).pop(); // Pops loading dialog
        var httpResponseBody = e.response?.data;
      }

      // refresh menu table
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      content: Container(
        width: double.maxFinite,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Food',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 25),
              Row(
                children: [
                  Text(
                    'Name',
                  ),
                  Text(
                    '*',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  )
                ],
              ),
              SizedBox(height: 8),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Food name is required';
                  }
                  return null;
                },
                controller: _nameFieldController,
                decoration: InputDecoration(
                  hintText: 'Name',
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.zero,
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Text(
                    'Price',
                  ),
                  Text(
                    '*',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  )
                ],
              ),
              SizedBox(height: 8),
              Container(
                width: 100,
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Price is required';
                    }
                    return null;
                  },
                  controller: _priceFieldController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    suffix: Text('PHP '),
                    hintText: 'Price',
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                  ),
                  onChanged: (string) {
                    string = NumberFormat.decimalPattern('en-PH')
                        .format(int.parse(string.replaceAll(',', '')));
                    _priceFieldController.value = TextEditingValue(
                      text: string,
                      selection: TextSelection.collapsed(offset: string.length),
                    );
                  },
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  DottedBorder(
                    color: primaryColor,
                    strokeWidth: 1,
                    child: GestureDetector(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: accentColor,
                          image: _foodImage != null
                              ? DecorationImage(
                                  image: FileImage(_foodImage!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        // padding: const EdgeInsets.all(40),
                        child: Icon(
                          Icons.add,
                          color: primaryColor,
                        ),
                      ),
                      onTap: _showImagePicker,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Upload Image',
                        style: TextStyle(
                          color: primaryColor,
                        ),
                      ),
                      Text(
                        'Image must be jpg, jpeg, png format',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        'Maximum of 10mb',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        primary: primaryColor,
                        padding: EdgeInsets.all(12),
                      ),
                      onPressed: _submitForm,
                      child: Text(
                        'Add',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 4),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        primary: Colors.white,
                        padding: EdgeInsets.all(12),
                      ),
                      onPressed: () {
                        _nameFieldController.clear();
                        _priceFieldController.clear();
                        _foodImage = null;
                        Navigator.of(context).pop(); // closes modal
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
