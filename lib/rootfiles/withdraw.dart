// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:evencross/reusablewidget/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Withdraw extends StatefulWidget {
  const Withdraw({super.key, required this.username, required this.balance});
  final String username;
  final int balance;

  @override
  State<Withdraw> createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  TextEditingController amountController = TextEditingController();
  bool selected = false;
  Future<void> submitForm() async {
    final url = Uri.parse(
        'https://evencross.online/dashboard/userapi/withdraw_request');
    final data = {
      'key': '818c56d73cc197fe899de713748b92dbed1a3f24',
      'username': widget.username,
      'amount': amountController.text,
    };

    try {
      final response = await http.post(url, body: data);
      var responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        // Success: do something with the response

        print('Response body: ${response.body}');
        print('given amount is ${amountController.text}');
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
        // Error: display the error message
        final msg = response.reasonPhrase ?? 'Unknown error';
        print('Error: $msg');
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
    } catch (e) {
      // Exception: display the exception message
      print('Exception: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    ScrollController listScrollController = ScrollController();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    bool isTapped = false;
    int selectedindex = 0;
    return Padding(
      padding: EdgeInsets.all(width * .04),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffF6C259),
              blackcolor,
            ],
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .1),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: height * .04,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'Withdrawal ',
                    style: TextStyle(
                      letterSpacing: 1.4,
                      color: whiteColor,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Poppins',
                      fontSize: 25,
                    ),
                    children: [
                      TextSpan(
                        text: 'Request',
                        style: TextStyle(
                          color: whiteColor,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Poppins',
                          fontSize: 25,
                          //height: 1.7,
                        ),
                      ),
                    ]),
              ),
              SizedBox(
                height: height * .04,
              ),
              Text(
                textAlign: TextAlign.start,
                'Balance: ${widget.balance}',
                style: TextStyle(
                    color: whiteColor,
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              ),
              Container(
                width: width,
                height: height * .06,
                decoration: BoxDecoration(
                    color: Color(0xffB7AF9E),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: width * .04),
                    child: TextField(
                        controller: amountController,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Amount',
                            hintStyle: TextStyle(
                                color: Color(0xff4A4A4A),
                                fontFamily: 'Poppins',
                                fontSize: 13,
                                fontWeight: FontWeight.w500))),
                  ),
                ),
              ),
              SizedBox(
                height: height * .04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (selected == false) {
                          selected = true;
                        } else {
                          selected = false;
                        }
                      });
                    },
                    child: Container(
                      width: width * .05,
                      height: width * .05,
                      decoration: BoxDecoration(
                          border: Border.all(color: whiteColor, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: selected ? Color(0xffF6C259) : null),
                    ),
                  ),
                  SizedBox(
                    width: width * .02,
                  ),
                  Text(
                    'I Agree to the terms and Conditions',
                    style: TextStyle(
                        color: Color(0xff8E7A7A),
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              SizedBox(
                height: height * .04,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    if (selected == true) {
                      double? value = double.tryParse(amountController.text);
                      value != null && value <= widget.balance
                          ? submitForm()
                          : showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Cannot Withdraw'),
                                  content: Text(
                                      'Your requested Amount is greater than available balance'),
                                  actions: [
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: Text('OK'))
                                  ],
                                );
                              });
                    }
                  },
                  child: Container(
                    height: height * .07,
                    width: width * .5,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff72654A),
                            blurRadius: 5,
                          )
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        color: Color(0xff151515)),
                    child: Center(
                      child: Text(
                        'WithDraw',
                        style: TextStyle(
                            color: Color(0xffF6C259),
                            fontFamily: 'Poppins',
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * .04,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
