// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:evencross/reusablewidget/colors.dart';
import 'package:evencross/rootfiles/homeroot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class Login_Popup extends StatefulWidget {
  const Login_Popup({Key? key}) : super(key: key);

  @override
  State<Login_Popup> createState() => _Login_PopupState();
}

class _Login_PopupState extends State<Login_Popup> {
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late String name;
  List<_SecItem> _items = [];
  String username = '';
  String password = ' ';
  bool loading = false;
  final _storage = new FlutterSecureStorage();

  Future<void> login(String username, String password, String key) async {
    final response = await http.post(
      Uri.parse(
          'https://evencross.online/dashboard/userapi/login/$username/$password/$key'),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      final status = jsonResponse['status'];
      if (status == 'success') {
        name = jsonResponse['ecrossname'];
        await getData(username, key);
      } else {
        print(response.statusCode);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Error"),
                content: const Text('Incorrect Username or Password'),
                actions: [
                  InkWell(
                    child: const Text("Ok"),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      }
    } else {
      print('error');
    }
  }

  Future<void> getData(String username, String key) async {
    final response = await http.get(
      Uri.parse(
        'https://evencross.online/dashboard/userapi/dashboard/$username/$key',
      ),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      final status = jsonResponse['status'];
      if (status == 'success') {
        int totalInvestment = jsonResponse['total_investment'];
        int totalIncome = jsonResponse['total_income'];
        int totalRefferals = jsonResponse['total_referals'];
        int commision = jsonResponse['brokerage_commission'];
        int monthlyProfit = jsonResponse['monthly_profit'];
        int totalWithdrawal = jsonResponse['total_withdrawal'];
        int balance = jsonResponse['balance'];

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Homeroot(
                username: username,
                totalInvestment: totalInvestment,
                totalIncome: totalIncome,
                totalRefferals: totalRefferals,
                commision: commision,
                monthlyProfit: monthlyProfit,
                totalWithdrawal: totalWithdrawal,
                password: passwordController.text,
                name: name,
                balance: balance),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to retrieve data'),
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // _readAll();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: height * .55,
        decoration: const BoxDecoration(
            color: blackcolor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        child: Padding(
          padding: EdgeInsets.only(left: width * .1, right: width * .1),
          child: Container(
              width: width * .9,
              child: loading
                  ? Container(
                      width: width * .9,
                      color: blackcolor,
                      child: Center(
                          child: CircularProgressIndicator(color: whiteColor)),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          const Spacer(),
                          Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                    text: "Login\n",
                                    style: const TextStyle(
                                      letterSpacing: 1.4,
                                      color: Color(0xffB5B5B5),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins',
                                      fontSize: 22,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Process',
                                        style: TextStyle(
                                          letterSpacing: 1.4,
                                          color: const Color(0xffF6C259)
                                              .withOpacity(.49),
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Poppins',
                                          fontSize: 22,
                                          //height: 1.7,
                                        ),
                                      ),
                                    ]),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 7, top: 20),
                                child: Image.asset(
                                  'images/gradientbar.png',
                                  height: width * .2,
                                  width: height * .21,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          SizedBox(
                            width: width * .91,
                            height: 70,
                            child: TextField(
                              controller: userController,
                              keyboardType: TextInputType.multiline,
                              textCapitalization: TextCapitalization.characters,
                              decoration: InputDecoration(
                                fillColor: blackcolor,
                                filled: true,
                                prefixIcon: const Icon(
                                  Icons.mail_outline,
                                  color: Color(0xffF6C259),
                                ),
                                hintText: "Userid",
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                    color: Color(0xff787878)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: const Color(0xffF6C259)
                                          .withOpacity(.49),
                                      width: .5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: const Color(0xffF6C259)
                                          .withOpacity(.41),
                                      width: .2),
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
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: width * .91,
                            height: 70,
                            child: TextField(
                              controller: passwordController,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                fillColor: blackcolor,
                                filled: true,
                                prefixIcon: const Icon(
                                  Icons.keyboard_alt_outlined,
                                  color: Color(0xffF6C259),
                                ),
                                hintText: "Password",
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                    color: Color(0xff787878)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: const Color(0xffF6C259)
                                          .withOpacity(.49),
                                      width: .5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: const Color(0xffF6C259)
                                          .withOpacity(.41),
                                      width: .2),
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
                          const SizedBox(
                            height: 20,
                          ),
                          // Text(
                          //   "Forget Password ?",
                          //   style: TextStyle(
                          //     fontFamily: 'Poppins',
                          //     fontSize: 17,
                          //     fontWeight: FontWeight.w300,
                          //     color: const Color(0xffF6C259).withOpacity(.4),
                          //   ),
                          // ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              _addNewItem();
                              login(
                                  userController.text,
                                  passwordController.text,
                                  '818c56d73cc197fe899de713748b92dbed1a3f24');
                            },
                            child: Container(
                              width: width * .9,
                              height: height * .08,
                              child: Image.asset(
                                'images/loginbutton.png',
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ),
                          const Spacer(),
                        ])),
        ),
      ),
    );
  }

  Future<void> _readAll() async {
    final all = await _storage.readAll(
      aOptions: _getAndroidOptions(),
    );
    setState(() {
      _items = all.entries
          .map((entry) => _SecItem(entry.key, entry.value))
          .toList(growable: false);
      username = _items[0].key;
      password = _items[0].value;
    });
    if (username.isNotEmpty || password.isNotEmpty) {
      login(username, password, '818c56d73cc197fe899de713748b92dbed1a3f24');
    } else {}
  }

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
        // sharedPreferencesName: 'Test2',
        // preferencesKeyPrefix: 'Test'
      );

  Future<void> _addNewItem() async {
    final String key = userController.text;
    final String value = passwordController.text;
    await _storage.write(
      key: key,
      aOptions: _getAndroidOptions(),
      value: value,
    );

    _readAll();
  }
}

class _SecItem {
  _SecItem(this.key, this.value);

  final String key;
  final String value;
}
