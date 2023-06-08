// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:evencross/reusablewidget/colors.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:image_picker/image_picker.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({Key? key, required this.username}) : super(key: key);
  final String username;

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  TextEditingController amountController = TextEditingController();
  TextEditingController receiptController = TextEditingController();
  File? _image;
  void _submitForm() async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://evencross.online/dashboard/userapi/investment'),
    );
    request.fields['key'] = '818c56d73cc197fe899de713748b92dbed1a3f24';
    request.fields['username'] = widget.username;
    request.fields['amount'] = amountController.text;
    request.fields['mode'] = currentindex == 0 ? 'upi' : 'bank';
    request.fields['ref'] = receiptController.text;

    if (_image != null) {
      var imagePart = await http.MultipartFile.fromPath(
        'userfile',
        _image!.path,
      );
      request.files.add(imagePart);
    }

    var response = await request.send();
    var streamedResponse = await http.Response.fromStream(response);
    var responseData = json.decode(streamedResponse.body);

    if (streamedResponse.statusCode == 200) {
      // TODO: Handle success response
      print(streamedResponse.body);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(responseData['status']),
              content: Text(responseData['msg']),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('OK'))
              ],
            );
          });
    } else {
      // TODO: Handle error response
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(responseData['status']),
              content: Text(responseData['msg']),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('OK'))
              ],
            );
          });
    }
  }

  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: blackcolor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Container(
              width: width,
              height: height * .92,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xffF6C259).withOpacity(.8),
                      blackcolor,
                    ],
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: width * .84,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.close,
                                  color: whiteColor,
                                ),
                              ))
                        ],
                      ),
                      RichText(
                        text: TextSpan(
                            text: "Payment",
                            style: TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Poppins',
                              fontSize: 30,
                            ),
                            children: [
                              TextSpan(
                                text: ' Method',
                                style: TextStyle(
                                  color: whiteColor,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: 'Poppins',
                                  fontSize: 30,
                                  //height: 1.7,
                                ),
                              ),
                            ]),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                currentindex = 0;
                              });
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Color(0xffD9D9D9),
                                  shape: BoxShape.circle),
                              child: Center(
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      color: currentindex == 0
                                          ? Color(0xffF6C259)
                                          : Color(0xffD9D9D9),
                                      shape: BoxShape.circle),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'UPI',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 22,
                                color: whiteColor,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                currentindex = 1;
                              });
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Color(0xffD9D9D9),
                                  shape: BoxShape.circle),
                              child: Center(
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      color: currentindex == 1
                                          ? Color(0xffF6C259)
                                          : Color(0xffD9D9D9),
                                      shape: BoxShape.circle),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Bank',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 22,
                                color: whiteColor,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Spacer(),
                      SizedBox(
                        width: width * .75,
                        height: 60,
                        child: TextField(
                          controller: amountController,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            fillColor: Color(0xffB7AF9E),
                            filled: true,
                            hintText: "Amount",
                            hintStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                color: Color(0xff4A4A4A)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Color(0xffB7AF9E), width: .5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Color(0xffB7AF9E), width: .2),
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 15.0,
                            height: 2,
                            fontWeight: FontWeight.w500,
                            color: blackcolor,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: width * .75,
                        height: 60,
                        child: TextField(
                          controller: receiptController,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            fillColor: Color(0xff937333),
                            filled: true,
                            hintText: "Receipt Number",
                            hintStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                color: whiteColor),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Color(0xff937333), width: .5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Color(0xff937333), width: .2),
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 15.0,
                            height: 2,
                            fontWeight: FontWeight.w500,
                            color: whiteColor,
                          ),
                          maxLines: 1,
                        ),
                      ),
                      Spacer(),
                      currentindex == 0
                          ? Container(
                              width: width * .52,
                              height: height * .23,
                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: QrImage(
                                  data: 'https://www.example.com',
                                  version: QrVersions.auto,
                                  // size: height * .23,
                                ),
                              ),
                            )
                          : Container(
                              width: width * .85,
                              height: height * .23,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Spacer(),
                                  Text(
                                    'Bank Details Below',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 22,
                                        color: whiteColor,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Spacer(),
                                  Text(
                                    'Acc No:  50200076902430',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 22,
                                        color: Color(0xffF6C259),
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Spacer(),
                                  Text(
                                    'Bank Name:',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 17,
                                        color: Color(0xffF6C259),
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Spacer(),
                                  Text(
                                    'EVENCROSS INTERNATIONAL PVT LTD',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 17,
                                        color: Color(0xffF6C259),
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Spacer(),
                                  Text(
                                    'Branch:  PALARIVATTAM',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 17,
                                        color: Color(0xffF6C259),
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Spacer(),
                                  Text(
                                    'IFSC : HDFC0000520',
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 17,
                                        color: Color(0xffF6C259),
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                      Spacer(),
                      Container(
                          width: width * .65,
                          height: height * .14,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xff656262),
                                    blurRadius: 3,
                                    spreadRadius: .01),
                              ],
                              color: Color(0xff1B1B1B),
                              borderRadius: BorderRadius.circular(10)),
                          child: _image == null
                              ? Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Spacer(),
                                    GestureDetector(
                                        onTap: () {
                                          _checkPermission();
                                        },
                                        child: Image.asset(
                                            'images/uploadicon.png')),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Upload Receipt',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 14,
                                          color: whiteColor,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Spacer(),
                                  ],
                                )
                              : GestureDetector(
                                  onTap: () {
                                    _checkPermission();
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      _image!.absolute,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                )),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          _submitForm();
                        },
                        child: Image.asset(
                          'images/submitbutton.png',
                          height: height * .12,
                          width: width * .52,
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future _getReceipt() async {
    final ImagePicker _picker = ImagePicker();
    var image = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 400,
      maxHeight: 400,
      imageQuality: 100,
    );
    if (image != null) {
      setState(() {
        _image = File(image.path);
        print("my img is $_image");
      });
    }
  }

  void _checkPermission() async {
    final permission = Permission.camera;
    final status = await permission.status;
    if (status == PermissionStatus.granted) {
      _getReceipt();
    } else {
      await permission.request();
    }
  }
}
