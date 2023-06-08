import 'dart:convert';

import 'package:evencross/reusablewidget/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BankDetails extends StatefulWidget {
  const BankDetails({Key? key, required this.username}) : super(key: key);
  final String username;

  @override
  State<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController accountholderController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController confirmAccountController = TextEditingController();
  TextEditingController gpayController = TextEditingController();
  TextEditingController phonepayController = TextEditingController();

  Map<String, dynamic> bankDetails = {};
  Future<void> submitForm() async {
    final url = Uri.parse(
        'https://evencross.online/dashboard/userapi/bank_details_request');
    final data = {
      'key': '818c56d73cc197fe899de713748b92dbed1a3f24',
      'username': widget.username,
      'ifsc': ifscController.text,
      'accounthldrname': accountholderController.text,
      'accntname': accountNumberController.text,
      'conacntnum': confirmAccountController.text,
      'bankname': bankNameController.text,
      'bankbranch': '',
      'mobnum': _mobileController.text,
      'gpaynum': gpayController.text,
      'phpaynum': phonepayController.text,
    };

    try {
      final response = await http.post(url, body: data);
      var responseData = json.decode(response.body);

      // Parse response JSON
      if (response.statusCode == 200) {
        final status = responseData['status'];
        if (status == 'success') {
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
        }
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

  late Map<String, dynamic> _results = {};

  Future<void> getData(String username, String key) async {
    final response = await http.get(
      Uri.parse(
        'https://evencross.online/dashboard/userapi/bank_details/$username/$key',
      ),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedData = json.decode(response.body);
      final status = decodedData['status'];
      if (status == 'success') {
        bankDetails = decodedData['bank_details'];
        setState(() {
          _results = bankDetails;
          accountNumberController.text = _results['accnt_num'];
          bankNameController.text = _results['bank_name'];
          accountholderController.text = _results['accnt_hldr_name'];
          ifscController.text = _results['ifsc'];
          _mobileController.text = _results['mobile_num'];
          phonepayController.text = _results['phpay_num'];
          gpayController.text = _results['gpay_num'];
          confirmAccountController.text = _results['confirm_accnt_num'];
        });
      }
    } else {
      print('HTTP Error: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    getData(widget.username, "818c56d73cc197fe899de713748b92dbed1a3f24");

    _usernameController = TextEditingController(text: widget.username);
  }

  int currentindex = 0;
  int val = 0;
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
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xffF6C259).withOpacity(.8),
                      blackcolor,
                    ],
                  ),
                  color: whiteColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Center(
                child: Column(
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
                            child: const Padding(
                              padding: EdgeInsets.only(right: 8.0, top: 8),
                              child: Icon(
                                Icons.close,
                                color: whiteColor,
                              ),
                            ))
                      ],
                    ),
                    RichText(
                      text: const TextSpan(
                          text: "Bank",
                          style: TextStyle(
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            fontSize: 25,
                          ),
                          children: [
                            TextSpan(
                              text: ' Details',
                              style: TextStyle(
                                color: whiteColor,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                                fontSize: 25,
                                //height: 1.7,
                              ),
                            ),
                          ]),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: width,
                      height: height * .82,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              //height: height*.82,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: height * .02,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: width * .082),
                                    child: const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'UserName',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 12,
                                            color: whiteColor,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: width * .75,
                                    height: height * .06,
                                    child: TextField(
                                      readOnly: true,
                                      controller: _usernameController,
                                      keyboardType: TextInputType.multiline,
                                      decoration: InputDecoration(
                                        fillColor: const Color(0xff937333),
                                        filled: true,
                                        hintStyle: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                            color: Color(0xffFFD582)),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: const Color(0xffF6C259)
                                                  .withOpacity(.49),
                                              width: .5),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: const Color(0xffF6C259)
                                                  .withOpacity(.41),
                                              width: .2),
                                        ),
                                      ),
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                        height: 1,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff4A4A4A),
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 22,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: width * .082),
                                    child: const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Account Holder Name',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 12,
                                            color: whiteColor,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: width * .75,
                                    height: height * .06,
                                    child: TextField(
                                      controller: accountholderController,
                                      keyboardType: TextInputType.multiline,
                                      decoration: InputDecoration(
                                        fillColor: const Color(0xffB7AF9E),
                                        filled: true,
                                        //hintText: "",
                                        hintStyle: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                            color: Color(0xff4A4A4A)),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: const Color(0xffB7AF9E)
                                                  .withOpacity(.49),
                                              width: .5),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: const Color(0xffB7AF9E)
                                                  .withOpacity(.41),
                                              width: .2),
                                        ),
                                      ),
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                        height: 1,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff4A4A4A),
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 22,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: width * .082),
                                    child: const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Account Number',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 12,
                                            color: whiteColor,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: width * .75,
                                    height: height * .06,
                                    child: TextField(
                                      controller: accountNumberController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        fillColor: const Color(0xffB7AF9E),
                                        filled: true,
                                        //hintText: "",
                                        hintStyle: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                            color: Color(0xff4A4A4A)),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: const Color(0xffB7AF9E)
                                                  .withOpacity(.49),
                                              width: .5),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: const Color(0xffB7AF9E)
                                                  .withOpacity(.41),
                                              width: .2),
                                        ),
                                      ),
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                        height: 1,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff4A4A4A),
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 22,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: width * .082),
                                    child: const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Confirm Account Number',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 12,
                                            color: whiteColor,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: width * .75,
                                    height: height * .06,
                                    child: TextField(
                                      controller: confirmAccountController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        fillColor: const Color(0xffB7AF9E),
                                        filled: true,
                                        //hintText: "",
                                        hintStyle: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                            color: Color(0xff4A4A4A)),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: const Color(0xffB7AF9E)
                                                  .withOpacity(.49),
                                              width: .5),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: const Color(0xffB7AF9E)
                                                  .withOpacity(.41),
                                              width: .2),
                                        ),
                                      ),
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                        height: 1,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff4A4A4A),
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 22,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: width * .082),
                                    child: const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Bank Name',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 12,
                                            color: whiteColor,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: width * .75,
                                    height: height * .06,
                                    child: TextField(
                                      controller: bankNameController,
                                      keyboardType: TextInputType.multiline,
                                      decoration: InputDecoration(
                                        fillColor: const Color(0xffB7AF9E),
                                        filled: true,
                                        //hintText: "",
                                        hintStyle: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                            color: Color(0xff4A4A4A)),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: const Color(0xffB7AF9E)
                                                  .withOpacity(.49),
                                              width: .5),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: const Color(0xffB7AF9E)
                                                  .withOpacity(.41),
                                              width: .2),
                                        ),
                                      ),
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                        height: 1,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff4A4A4A),
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 22,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: width * .082),
                                    child: const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Mobile Number',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 12,
                                            color: whiteColor,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: width * .75,
                                    height: height * .06,
                                    child: TextField(
                                      controller: _mobileController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        fillColor: const Color(0xffB7AF9E),
                                        filled: true,
                                        //hintText: "",
                                        hintStyle: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                            color: Color(0xff4A4A4A)),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: const Color(0xffB7AF9E)
                                                  .withOpacity(.49),
                                              width: .5),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: const Color(0xffB7AF9E)
                                                  .withOpacity(.41),
                                              width: .2),
                                        ),
                                      ),
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                        height: 1,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff4A4A4A),
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 22,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: width * .082),
                                    child: const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'IFSC',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 12,
                                            color: whiteColor,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: width * .75,
                                    height: height * .06,
                                    child: TextField(
                                      controller: ifscController,
                                      keyboardType: TextInputType.multiline,
                                      decoration: InputDecoration(
                                        fillColor: const Color(0xffB7AF9E),
                                        filled: true,
                                        //hintText: "",
                                        hintStyle: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                            color: Color(0xff4A4A4A)),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: const Color(0xffB7AF9E)
                                                  .withOpacity(.49),
                                              width: .5),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: const Color(0xffB7AF9E)
                                                  .withOpacity(.41),
                                              width: .2),
                                        ),
                                      ),
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                        height: 1,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff4A4A4A),
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 22,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: width * .082),
                                    child: const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Google Pay',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 12,
                                            color: whiteColor,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: width * .75,
                                    height: height * .06,
                                    child: TextField(
                                      controller: gpayController,
                                      keyboardType: TextInputType.multiline,
                                      decoration: InputDecoration(
                                        fillColor: const Color(0xffB7AF9E),
                                        filled: true,
                                        //hintText: "",
                                        hintStyle: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                            color: Color(0xff4A4A4A)),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: const Color(0xffB7AF9E)
                                                  .withOpacity(.49),
                                              width: .5),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: const Color(0xffB7AF9E)
                                                  .withOpacity(.41),
                                              width: .2),
                                        ),
                                      ),
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                        height: 1,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff4A4A4A),
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 22,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: width * .082),
                                    child: const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Phone Pe',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 12,
                                            color: whiteColor,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: width * .75,
                                    height: height * .06,
                                    child: TextField(
                                      controller: phonepayController,
                                      keyboardType: TextInputType.multiline,
                                      decoration: InputDecoration(
                                        fillColor: const Color(0xffB7AF9E),
                                        filled: true,
                                        //hintText: "",
                                        hintStyle: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                            color: Color(0xff4A4A4A)),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: const Color(0xffB7AF9E)
                                                  .withOpacity(.49),
                                              width: .5),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: const Color(0xffB7AF9E)
                                                  .withOpacity(.41),
                                              width: .2),
                                        ),
                                      ),
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                        height: 1,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff4A4A4A),
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      submitForm();
                                    },
                                    child: Container(
                                      height: height * .12,
                                      width: width * .75,
                                      child: Column(
                                        children: [
                                          Container(
                                            width: width * .62,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: const Color(0xffF6C259),
                                            ),
                                            child: Center(
                                              child: RichText(
                                                text: const TextSpan(
                                                    text: "Update Bank",
                                                    style: TextStyle(
                                                      color: blackcolor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: 'Poppins',
                                                      fontSize: 20,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text: ' Details',
                                                        style: TextStyle(
                                                          color: whiteColor,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily: 'Poppins',
                                                          fontSize: 20,
                                                          //height: 1.7,
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
