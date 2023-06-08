// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:evencross/accountskyc/accountskyc.dart';
import 'package:evencross/accountskyc/accountuser.dart';
import 'package:evencross/accountskyc/bankdetails.dart';
import 'package:evencross/reusablewidget/colors.dart';
import 'package:evencross/rootfiles/resetpassword.dart';
import 'package:evencross/splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AccountSection extends StatefulWidget {
  const AccountSection(
      {Key? key,
      required this.username,
      required this.password,
      required this.name})
      : super(key: key);
  final String username;
  final String password;
  final String name;

  @override
  State<AccountSection> createState() => _AccountSectionState();
}

class _AccountSectionState extends State<AccountSection> {
  String key = "818c56d73cc197fe899de713748b92dbed1a3f24";
  int selectedindex = 0;
  List<_SecItem> _items = [];
  int selectedBox = 0;
  final _storage = new FlutterSecureStorage();
  TextEditingController description = TextEditingController();

  Future<void> accountDetails() async {
    final url = Uri.parse('https://evencross.online/dashboard/userapi/support');
    final data = {
      'key': key,
      'user_id': widget.username,
      'msg_mode': selectedBox == 0
          ? "withdraw"
          : selectedBox == 1
              ? "invest"
              : "others",
      'description': description.text.toString(),
    };

    try {
      final response = await http.post(url, body: data);
      var responseData = json.decode(response.body);

      // Parse response JSON
      if (response.statusCode == 200) {
        // Success: do something with the response
        print('Response body: ${response.body}');

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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: blackcolor,
        body: SingleChildScrollView(
          child: Container(
            height: height * 1,
            width: width,
            child: Padding(
              padding: EdgeInsets.only(left: width * .1, right: width * .1),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Spacer(),
                  SizedBox(
                    height: height * .06,
                  ),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Account Details',
                          style: TextStyle(
                              letterSpacing: 1.1,
                              fontFamily: 'Montserrat',
                              fontSize: 28,
                              color: whiteColor,
                              fontWeight: FontWeight.w600),
                        ),
                        GestureDetector(
                          onTap: () {
                            _deleteAll();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SplashScreen()));
                          },
                          child: Icon(
                            Icons.login_rounded,
                            color: whiteColor,
                            size: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * .04,
                  ),
                  SizedBox(
                    height: height * .82,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            child: Column(
                              children: [
                                Text(
                                  widget.username,
                                  style: TextStyle(
                                    letterSpacing: 1.4,
                                    color: Color(0xffF9D296),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                    //height: 1.7,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Bottompopup();
                                  },
                                  child: Text(
                                    'RESET PASSWORD',
                                    style: TextStyle(
                                      letterSpacing: 1.4,
                                      color: whiteColor,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins',
                                      fontSize: 8,
                                      //height: 1.7,
                                    ),
                                  ),
                                ),
                                Divider(
                                  height: height * .05,
                                  color: Colors.white,
                                  indent: 15,
                                ),
                                Text(
                                  'Get Support',
                                  style: TextStyle(
                                    letterSpacing: 1.4,
                                    color: whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Poppins',
                                    fontSize: 20,
                                    //height: 1.7,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedBox = 0;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            border: selectedBox == 0
                                                ? Border.all(color: gold)
                                                : Border.all(
                                                    color: Color(0xFFBBBBBB))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Withdraw Support',
                                            style: TextStyle(
                                              color: whiteColor,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Poppins',
                                              fontSize: 8,
                                              //height: 1.7,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedBox = 1;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            border: selectedBox == 1
                                                ? Border.all(color: gold)
                                                : Border.all(
                                                    color: Color(0xFFBBBBBB))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Investment Support',
                                            style: TextStyle(
                                              color: whiteColor,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Poppins',
                                              fontSize: 8,
                                              //height: 1.7,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedBox = 2;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            border: selectedBox == 2
                                                ? Border.all(color: gold)
                                                : Border.all(
                                                    color: Color(0xFFBBBBBB))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Others',
                                            style: TextStyle(
                                              color: whiteColor,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Poppins',
                                              fontSize: 8,
                                              //height: 1.7,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * .05,
                          ),
                          SizedBox(
                            height: height * .18,
                            child: TextField(
                              controller: description,
                              maxLines: 7,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFF4E4E4E),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: greycolor),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: greycolor,
                                  ),
                                ),
                              ),
                              style: TextStyle(color: whiteColor),
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (description.text.isEmpty) {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text(
                                                'Message cant be empty'),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.of(context).pop(),
                                                child: const Text('OK'),
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    } else {
                                      accountDetails();
                                    }
                                  },
                                  child: Container(
                                    height: height * .08,
                                    width: width / 2,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                        color: Color(0xffF6C259)),
                                    child: Center(
                                      child: RichText(
                                        text: TextSpan(
                                            text: 'Send ',
                                            style: TextStyle(
                                              // letterSpacing: 1.4,
                                              color: blackcolor,
                                              // fontWeight: FontWeight.w300,
                                              fontFamily: 'Poppins',
                                              fontSize: 15,
                                            ),
                                            children: const [
                                              TextSpan(
                                                text: 'Message',
                                                style: TextStyle(
                                                  color: whiteColor,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Poppins',
                                                  fontSize: 15,
                                                  //height: 1.7,
                                                ),
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * .02,
                          ),
                          SizedBox(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedindex = 0;
                                });
                              },
                              child: Container(
                                width: width,
                                height: height * .15,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedindex = 0;
                                            });
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AccountUser(
                                                          username:
                                                              widget.username,
                                                          name: widget.name,
                                                          password:
                                                              widget.password,
                                                        )));
                                          },
                                          child: Container(
                                            width: width * .2,
                                            height: width * .2,
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  selectedindex == 0
                                                      ? BoxShadow(
                                                          color: gold,
                                                          blurRadius: 3,
                                                          spreadRadius: .01)
                                                      : BoxShadow(
                                                          blurRadius: 3,
                                                          spreadRadius: .01)
                                                ],
                                                color: Color(0xff222222),
                                                shape: BoxShape.circle),
                                            child: Center(
                                              child: Image.asset(
                                                'images/personicon.png',
                                                height: 30,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'USER',
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 10,
                                              color: Color(0xffFAD092),
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          'DETAILS',
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 10,
                                              color: whiteColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedindex = 1;
                                            });
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BankDetails(
                                                            username: widget
                                                                .username)));
                                          },
                                          child: Container(
                                            width: width * .2,
                                            height: width * .2,
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  selectedindex == 1
                                                      ? BoxShadow(
                                                          color: gold,
                                                          blurRadius: 3,
                                                          spreadRadius: .01)
                                                      : BoxShadow(
                                                          blurRadius: 3,
                                                          spreadRadius: .01)
                                                ],
                                                color: Color(0xff222222),
                                                shape: BoxShape.circle),
                                            child: Center(
                                              child: Image.asset(
                                                'images/sdollar.png',
                                                height: 30,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'BANK',
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 10,
                                              color: Color(0xffFAD092),
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          'DETAILS',
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 10,
                                              color: whiteColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedindex = 2;
                                            });
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AccountKyc(
                                                            username: widget
                                                                .username)));
                                          },
                                          child: Container(
                                            width: width * .2,
                                            height: width * .2,
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  selectedindex == 2
                                                      ? BoxShadow(
                                                          color: gold,
                                                          blurRadius: 3,
                                                          spreadRadius: .01)
                                                      : BoxShadow(
                                                          blurRadius: 3,
                                                          spreadRadius: .01)
                                                ],
                                                color: Color(0xff222222),
                                                shape: BoxShape.circle),
                                            child: Center(
                                              child: Image.asset(
                                                'images/kyc.png',
                                                height: 35,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'KYC',
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 10,
                                              color: Color(0xffFAD092),
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          'REQUEST',
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 10,
                                              color: whiteColor,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> _deleteAll() async {
    await _storage.deleteAll(
      // iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
    _readAll();
  }

  Future<void> _readAll() async {
    final all = await _storage.readAll(
      aOptions: _getAndroidOptions(),
    );
    setState(() {
      _items = all.entries
          .map((entry) => _SecItem(entry.key, entry.value))
          .toList(growable: false);
    });
  }

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
        // sharedPreferencesName: 'Test2',
        // preferencesKeyPrefix: 'Test'
      );
  Bottompopup() {
    showModalBottomSheet<void>(
        isScrollControlled: true,
        // context and builder are
        // required properties in this widget
        context: context,
        shape: const RoundedRectangleBorder(
          // <-- SEE HERE
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25),
          ),
        ),
        builder: (BuildContext context) {
          return Resetpassword(
            username: widget.username,
            Password: widget.password,
          );
        });
  }
}

class _SecItem {
  _SecItem(this.key, this.value);

  final String key;
  final String value;
}
