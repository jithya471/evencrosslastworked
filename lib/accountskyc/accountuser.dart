import 'dart:convert';

import 'package:evencross/reusablewidget/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AccountUser extends StatefulWidget {
  const AccountUser(
      {Key? key,
      required this.username,
      required this.password,
      required this.name})
      : super(key: key);
  final String username;
  final String password;
  final String name;

  @override
  State<AccountUser> createState() => _AccountUserState();
}

class _AccountUserState extends State<AccountUser> {
  int currentindex = 0;
  int val = 0;
  String modifieddate = "";
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _doorController = TextEditingController();
  TextEditingController _streetController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _districtController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _pincodeController = TextEditingController();
  TextEditingController _monthController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _yearController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _genderController = TextEditingController();

  Future<void> submitForm() async {
    modifieddate = _dateController.text +
        "-" +
        _monthController.text +
        "-" +
        _yearController.text;
    final url = Uri.parse(
        'https://evencross.online/dashboard/userapi/user_details_request');
    final data = {
      'key': '818c56d73cc197fe899de713748b92dbed1a3f24',
      'username': widget.username,
      'name': _nameController.text,
      'email': '',
      'gender': currentindex == 0 ? 'male' : 'female',
      'mobile': _mobileController.text,
      'dob': modifieddate,
      'door': _doorController.text,
      'street': _streetController.text,
      'district': _districtController.text,
      'city': _cityController.text,
      'state': _stateController.text,
      'country': _countryController.text,
      'pincode': _pincodeController.text,
    };

    try {
      final response = await http.post(url, body: data);
      var responseData = json.decode(response.body);

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
 String Gender='';
  late Map<String, dynamic> _results = {};
  Map<String, dynamic> userDetails = {};

  Future<void> getData(String username, String key) async {
    final response = await http.get(
      Uri.parse(
        'https://evencross.online/dashboard/userapi/user_details/$username/$key',
      ),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedData = json.decode(response.body);
      final status = decodedData['status'];
      if (status == 'success') {
        userDetails = decodedData['user_details'];
        setState(() {
          _results = userDetails;
          print(_results);

          String dateString = _results['dob'];
          List<String> dateParts = dateString.split("-");
          print(_results['dob']);
          String day = dateParts[0];
          String month = dateParts[1];
          String year = dateParts[2];
          _dateController.text = day;
          _monthController.text = month;
          _yearController.text = year;
          _nameController.text = _results['name'];
          _mobileController.text = _results['mobile'];
          _dobController.text = _results['dob'];
          _doorController.text = _results['door'];
          _streetController.text = _results['street'];
          _districtController.text = _results['district'];
          _cityController.text = _results['city'];
          _stateController.text = _results['state'];
          _countryController.text = _results['country'];
          _pincodeController.text = _results['pincode'];
          _genderController.text = _results['gender'];
          // print(_results['gender']);
          Gender = _results['gender'];
          print(Gender);
          if(Gender=='female'){
            currentindex=1;
          }else{
            currentindex=0;
          }
        });
      }
    } else {
      print('HTTP Error: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.username);
    _passwordController = TextEditingController(text: widget.password);
    _nameController = TextEditingController(text: widget.name);
    _dobController = TextEditingController();
    getData(widget.username, "818c56d73cc197fe899de713748b92dbed1a3f24");
    // _results['gender'] == 'male' ? currentindex = 0 : 1;
    // print('gender $Gender');
  }

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
              height: height * .92,
              width: width,
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
              child: Container(
                width: width,
                // height: height * .12,
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
                                padding: EdgeInsets.only(top: 8.0, right: 8),
                                child: Icon(
                                  Icons.close,
                                  color: whiteColor,
                                ),
                              ))
                        ],
                      ),
                      RichText(
                        text: const TextSpan(
                            text: "USER",
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
                        height: 20,
                      ),
                      SizedBox(
                        width: width,
                        height: height * .8,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                        decoration: const BoxDecoration(
                                            color: Color(0xffD9D9D9),
                                            shape: BoxShape.circle),
                                        child: Center(
                                          child: Container(
                                            width: 25,
                                            height: 25,
                                            decoration: BoxDecoration(
                                                color: currentindex == 0
                                                    ? const Color(0xffF6C259)
                                                    : const Color(0xffD9D9D9),
                                                shape: BoxShape.circle),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    const Text(
                                      'Male',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 22,
                                          color: whiteColor,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const SizedBox(
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
                                        decoration: const BoxDecoration(
                                            color: Color(0xffD9D9D9),
                                            shape: BoxShape.circle),
                                        child: Center(
                                          child: Container(
                                            width: 25,
                                            height: 25,
                                            decoration: BoxDecoration(
                                                color: currentindex == 1
                                                    ? const Color(0xffF6C259)
                                                    : const Color(0xffD9D9D9),
                                                shape: BoxShape.circle),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    const Text(
                                      'Female',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 22,
                                          color: whiteColor,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: height * .05,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: width * .082),
                                      child: const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Name',
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
                                        controller: _nameController,
                                        keyboardType: TextInputType.multiline,
                                        decoration: InputDecoration(
                                          fillColor: const Color(0xffB7AF9E),
                                          filled: true,
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
                                        controller: _usernameController,
                                        readOnly: true,
                                        keyboardType: TextInputType.multiline,
                                        decoration: InputDecoration(
                                          fillColor: const Color(0xff937333),
                                          filled: true,
                                          //hintText: "",
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
                                          color: Color(0xffFFD582),
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
                                          'Password',
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
                                        controller: _passwordController,
                                        keyboardType: TextInputType.multiline,
                                        decoration: InputDecoration(
                                          fillColor: const Color(0xff937333),
                                          filled: true,
                                          //hintText: "",
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
                                          color: Color(0xffFFD582),
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
                                          'Mobile No',
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
                                          fillColor: const Color(0xff937333),
                                          filled: true,
                                          //hintText: "",
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
                                          color: Color(0xffFFD582),
                                        ),
                                        maxLines: 1,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 22,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: width * .082,
                                          right: width * .082),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'DOB',
                                              style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 15,
                                                  color: whiteColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(
                                            width: width * .12,
                                            height: height * .09,
                                            child: Center(
                                              child: TextField(
                                                controller: _dateController,
                                                textAlign: TextAlign.center,
                                                maxLength: 2,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  counterText: "",
                                                  fillColor:
                                                      const Color(0xffB7AF9E),
                                                  filled: true,
                                                  hintText: "dd",
                                                  hintStyle: const TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 14,
                                                      color: whiteColor),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide: BorderSide(
                                                        color: const Color(
                                                                0xffF6C259)
                                                            .withOpacity(.49),
                                                        width: .5),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide: BorderSide(
                                                        color: const Color(
                                                                0xffF6C259)
                                                            .withOpacity(.41),
                                                        width: .2),
                                                  ),
                                                ),
                                                style: const TextStyle(
                                                  fontSize: 15.0,
                                                  height: 1,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black87,
                                                ),
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: width * .18,
                                            height: height * .09,
                                            child: Center(
                                              child: TextField(
                                                controller: _monthController,
                                                textAlign: TextAlign.center,
                                                maxLength: 2,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  counterText: "",
                                                  fillColor:
                                                      const Color(0xffB7AF9E),
                                                  filled: true,
                                                  hintText: "mm",
                                                  hintStyle: const TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 14,
                                                      color: whiteColor),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide: BorderSide(
                                                        color: const Color(
                                                                0xffF6C259)
                                                            .withOpacity(.49),
                                                        width: .5),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide: BorderSide(
                                                        color: const Color(
                                                                0xffF6C259)
                                                            .withOpacity(.41),
                                                        width: .2),
                                                  ),
                                                ),
                                                style: const TextStyle(
                                                  fontSize: 15.0,
                                                  height: 1,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black87,
                                                ),
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: width * .23,
                                            height: height * .09,
                                            child: Center(
                                              child: TextField(
                                                onSubmitted: (val) {
                                                  modifieddate = _dateController
                                                          .text +
                                                      "-" +
                                                      _monthController.text +
                                                      "-" +
                                                      _yearController.text;
                                                  print(modifieddate);
                                                },
                                                controller: _yearController,
                                                textAlign: TextAlign.center,
                                                maxLength: 4,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  counterText: "",
                                                  fillColor:
                                                      const Color(0xffB7AF9E),
                                                  filled: true,
                                                  hintText: "yyyy",
                                                  hintStyle: const TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 14,
                                                      color: whiteColor),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide: BorderSide(
                                                        color: const Color(
                                                                0xffF6C259)
                                                            .withOpacity(.49),
                                                        width: .5),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide: BorderSide(
                                                        color: const Color(
                                                                0xffF6C259)
                                                            .withOpacity(.41),
                                                        width: .2),
                                                  ),
                                                ),
                                                style: const TextStyle(
                                                  fontSize: 15.0,
                                                  height: 1,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black87,
                                                ),
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                        ],
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
                                          'Door',
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
                                        controller: _doorController,
                                        keyboardType: TextInputType.multiline,
                                        decoration: InputDecoration(
                                          fillColor: const Color(0xff937333),
                                          filled: true,
                                          //hintText: "",
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
                                          color: Color(0xffFFD582),
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
                                          'Street',
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
                                        controller: _streetController,
                                        keyboardType: TextInputType.multiline,
                                        decoration: InputDecoration(
                                          fillColor: const Color(0xff937333),
                                          filled: true,
                                          //hintText: "",
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
                                          color: Color(0xffFFD582),
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
                                          'District',
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
                                        controller: _districtController,
                                        keyboardType: TextInputType.multiline,
                                        decoration: InputDecoration(
                                          fillColor: const Color(0xff937333),
                                          filled: true,
                                          //hintText: "",
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
                                          color: Color(0xffFFD582),
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
                                          'City',
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
                                        controller: _cityController,
                                        keyboardType: TextInputType.multiline,
                                        decoration: InputDecoration(
                                          fillColor: const Color(0xff937333),
                                          filled: true,
                                          //hintText: "",
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
                                          color: Color(0xffFFD582),
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
                                          'State',
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
                                        controller: _stateController,
                                        keyboardType: TextInputType.multiline,
                                        decoration: InputDecoration(
                                          fillColor: const Color(0xff937333),
                                          filled: true,
                                          //hintText: "",
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
                                          color: Color(0xffFFD582),
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
                                          'Country',
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
                                        controller: _countryController,
                                        keyboardType: TextInputType.multiline,
                                        decoration: InputDecoration(
                                          fillColor: const Color(0xff937333),
                                          filled: true,
                                          //hintText: "",
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
                                          color: Color(0xffFFD582),
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
                                          'Pincode',
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
                                        controller: _pincodeController,
                                        keyboardType: TextInputType.multiline,
                                        decoration: InputDecoration(
                                          fillColor: const Color(0xff937333),
                                          filled: true,
                                          //hintText: "",
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
                                          color: Color(0xffFFD582),
                                        ),
                                        maxLines: 1,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 22,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (int.parse(_dateController.text) >
                                                31 ||
                                            int.parse(_monthController.text) >
                                                12) {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text("Invalid Dob"),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () =>
                                                            Navigator.of(
                                                                    context)
                                                                .pop(),
                                                        child: Text('OK'))
                                                  ],
                                                );
                                              });
                                        } else {
                                          submitForm();
                                        }
                                      },
                                      child: Container(
                                        width: width * .52,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: const Color(0xffF6C259),
                                        ),
                                        child: Center(
                                          child: RichText(
                                            text: const TextSpan(
                                                text: "Save",
                                                style: TextStyle(
                                                  color: blackcolor,
                                                  fontWeight: FontWeight.w500,
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
                                    ),
                                    const SizedBox(
                                      height: 22,
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
      ),
    );
  }
}
