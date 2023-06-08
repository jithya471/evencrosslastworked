import 'dart:convert';

import 'package:evencross/reusablewidget/colors.dart';
import 'package:evencross/splashscreen/getstarted.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../rootfiles/homeroot.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _storage = new FlutterSecureStorage();
  List<_SecItem> _items = [];
  String username = '';
  String password = ' ';
  late String name;
  @override
  initState() {
    // TODO: implement initState
    _readAll();
    super.initState();

    Future.delayed(const Duration(seconds: 4), () {
      if (username.isEmpty || password.isEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Get_Started()),
        );
      } else {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => Get_Started()),
        // );
        login(username, password, '818c56d73cc197fe899de713748b92dbed1a3f24');
      }
    });
  }

  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: blackcolor,
      body: Center(
        child: Image.asset(
          'images/splashlogo.png',
          height: width * .55,
          width: height * .45,
        ),
      ),
    );
  }

  Future<void> _readAll() async {
    final all = await _storage.readAll(
      // iOptions: _getIOSOptions(),
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
        _deleteAll();
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

  Future<void> _deleteAll() async {
    await _storage.deleteAll(
      // iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
    _readAll();
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
                password: password,
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
}

class _SecItem {
  _SecItem(this.key, this.value);

  final String key;
  final String value;
}
