// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:evencross/reusablewidget/colors.dart';
import 'package:flutter/material.dart';

class Resetpassword extends StatefulWidget {
  Resetpassword({required this.Password, required this.username});
  String Password;
  String username;
  @override
  State<Resetpassword> createState() => _ResetpasswordState();
}

class _ResetpasswordState extends State<Resetpassword> {
  final _storage = new FlutterSecureStorage();
  List<_SecItem> _items = [];
  TextEditingController _newpassController = TextEditingController();
  TextEditingController _confirmpassController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("3456");
  }

  @override
  Widget build(BuildContext context) {
    ScrollController listScrollController = ScrollController();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: height * .4,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xffF6C259).withOpacity(.8),
              blackcolor,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0xffF6C259),
              blurRadius: 2,
            )
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 20),
                child: Text(
                  'Reset Password',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 32,
                      color: whiteColor,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(
              width: width * .91,
              height: 60,
              child: TextField(
                controller: _newpassController,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  fillColor: whiteColor,
                  filled: true,
                  hintText: "New Password",
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: const Color(0xffF6C259).withOpacity(.49),
                        width: .5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: const Color(0xffF6C259).withOpacity(.41),
                        width: .2),
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
              width: width * .91,
              height: 60,
              child: TextField(
                controller: _confirmpassController,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  fillColor: whiteColor,
                  filled: true,
                  hintText: "Confirm Password",
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: const Color(0xffF6C259).withOpacity(.49),
                        width: .5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: const Color(0xffF6C259).withOpacity(.41),
                        width: .2),
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
            GestureDetector(
              onTap: () {
                updatepassword();
              },
              child: Container(
                width: width * .6,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Color(0xffF6C259),
                ),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                        text: "Save",
                        style: TextStyle(
                          color: blackcolor,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                          fontSize: 20,
                        ),
                        children: const [
                          TextSpan(
                            text: ' Password',
                            style: TextStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              //height: 1.7,
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Future<void> updatepassword() async {
    final url =
        Uri.parse('https://evencross.online/dashboard/userapi/reset_password');
    final data = {
      'key': "818c56d73cc197fe899de713748b92dbed1a3f24",
      'username': widget.username,
      'oldpass': widget.Password,
      'newpass': _newpassController.text.toString(),
      'conpass': _confirmpassController.text.toString(),
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
        _deleteAll();
      } else {
        print('Response body: ${response.body}');
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
}

class _SecItem {
  _SecItem(this.key, this.value);

  final String key;
  final String value;
}
