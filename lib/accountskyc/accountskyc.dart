// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'package:evencross/reusablewidget/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

class AccountKyc extends StatefulWidget {
  const AccountKyc({Key? key, required this.username}) : super(key: key);
  final String username;

  @override
  State<AccountKyc> createState() => _AccountKycState();
}

class _AccountKycState extends State<AccountKyc> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController adharController = TextEditingController();

  TextEditingController panController = TextEditingController();
  String? aadharback = "";
  String? aadharfront = "";
  String? pancard = "";
  File? _image;
  File? _panimage;
  File? _adharimage;
  File? aadharBackImage;
  File? panBackImage;

  void _submitForm() async {
    final url =
        Uri.parse('https://evencross.online/dashboard/userapi/kyc_request');
    final request = http.MultipartRequest('POST', url);

    // Add form fields
    request.fields['key'] = '818c56d73cc197fe899de713748b92dbed1a3f24';
    request.fields['username'] = widget.username;
    request.fields['aadharnum'] = adharController.text;
    request.fields['pannum'] = panController.text;

    // Add images
    if (_image != null) {
      // Check file size before adding to request
      if (!checkFileSize(_image!.path)) {
        // Show snackbar if file size is too large
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Image size should be less than 2.5MB.'),
        ));
        return;
      }
      request.files.add(await http.MultipartFile.fromPath('af', _image!.path));
    }
    if (_adharimage != null) {
      request.files
          .add(await http.MultipartFile.fromPath('ab', _adharimage!.path));
    }

    if (_panimage != null) {
      request.files
          .add(await http.MultipartFile.fromPath('pf', _panimage!.path));
    }

    // Send API request
    var response = await request.send();
    var streamedResponse = await http.Response.fromStream(response);

    // Parse response JSON
    var responseData = json.decode(streamedResponse.body);
    if (streamedResponse.statusCode == 200) {
      final status = responseData['status'];
      if (status == 'success') {
        print(streamedResponse.body);
        setState(() {
          isLoading = false;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(responseData['status']),
              content: Text(responseData['msg']),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      print(streamedResponse.body);
      print(streamedResponse.statusCode);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(responseData['status']),
            content: Text(responseData['msg']),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  bool isLoading = false;
  late Map<String, dynamic> _results = {};
  Map<String, dynamic> kycDetails = {};

  Future<void> getData(String username, String key) async {
    final response = await http.get(
      Uri.parse(
        'https://evencross.online/dashboard/userapi/kyc_details/$username/$key',
      ),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedData = json.decode(response.body);
      final status = decodedData['status'];
      if (status == 'success') {
        kycDetails = decodedData['kyc_details'];
        setState(() {
          _results = kycDetails;
          print(_results);
          aadharback =
              "https://evencross.online/dashboard/assets/kyc_img/${_results["aadhar_img_back"]}";
          aadharfront =
              "https://evencross.online/dashboard/assets/kyc_img/${_results["aadhar_img"]}";
          pancard =
              "https://evencross.online/dashboard/assets/kyc_img/${_results["pan_img"]}";

          adharController.text = _results['aadhar_num'];
          panController.text = _results['pan_num'];
          print("my aadar ---");
        });
      }
    } else {
      print('HTTP Error: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
// Here you can write your code
      getData(widget.username, "818c56d73cc197fe899de713748b92dbed1a3f24");
    });

    _usernameController = TextEditingController(text: widget.username);
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
              width: width,
              height: height * 1.2,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xffF6C259).withOpacity(.8),
                      blackcolor,
                    ],
                  ),
                  color: whiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Container(
                width: width,
                height: height * .94,
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
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Icon(
                                Icons.close,
                                color: whiteColor,
                              ),
                            ))
                      ],
                    ),
                    RichText(
                      text: TextSpan(
                          text: "KYC",
                          style: TextStyle(
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            fontSize: 25,
                          ),
                          children: const [
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
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(left: width * .082),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'USERNAME',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 12,
                              color: whiteColor,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: width * .75,
                      height: 60,
                      child: TextField(
                        readOnly: true,
                        controller: _usernameController,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          fillColor: Color(0xff937333),
                          filled: true,
                          hintStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              color: Color(0xffFFD582)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Color(0xffF6C259).withOpacity(.49),
                                width: .5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Color(0xffF6C259).withOpacity(.41),
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
                    SizedBox(
                      height: 22,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width * .082),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'AADAR NO',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 12,
                              color: whiteColor,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: width * .75,
                      height: 60,
                      child: TextField(
                        controller: adharController,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          fillColor: Color(0xffB7AF9E),
                          filled: true,
                          hintText: "Enter Your Aadhar no",
                          hintStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              color: Color(0xff4A4A4A)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Color(0xffF6C259).withOpacity(.49),
                                width: .5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Color(0xffF6C259).withOpacity(.41),
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
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        _checkPermission();
                      },
                      child: Container(
                          width: width * .7,
                          height: height * .15,
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    color: Color(0xff656262),
                                    blurRadius: 3,
                                    spreadRadius: .01),
                              ],
                              color: Color(0xff1B1B1B),
                              borderRadius: BorderRadius.circular(10)),
                          child: _image != null
                              ? GestureDetector(
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
                                )
                              : aadharfront != ""
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        "$aadharfront",
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Spacer(),
                                        Image.asset(
                                          'images/uploadicon.png',
                                          height: 20,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Upload Aadhar Image front',
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 14,
                                              color: whiteColor,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        Spacer(),
                                      ],
                                    )),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    GestureDetector(
                      onTap: () {
                        _checkadharPermission();
                      },
                      child: Container(
                          width: width * .7,
                          height: height * .15,
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    color: Color(0xff656262),
                                    blurRadius: 3,
                                    spreadRadius: .01),
                              ],
                              color: Color(0xff1B1B1B),
                              borderRadius: BorderRadius.circular(10)),
                          child: _adharimage != null
                              ? GestureDetector(
                                  onTap: () {
                                    _checkadharPermission();
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      _adharimage!.absolute,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                )
                              : aadharback != ""
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        "$aadharback",
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Spacer(),
                                        Image.asset(
                                          'images/uploadicon.png',
                                          height: 20,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Upload Aadhar Image back',
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 14,
                                              color: whiteColor,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        Spacer(),
                                      ],
                                    )),
                    ),
                    SizedBox(
                      height: 22,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width * .082),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'PAN NO',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 12,
                              color: whiteColor,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: width * .75,
                      height: 60,
                      child: TextField(
                        controller: panController,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          fillColor: Color(0xffB7AF9E),
                          filled: true,
                          hintText: "Enter Your PAN no",
                          hintStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              color: Color(0xff4A4A4A)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Color(0xffF6C259).withOpacity(.49),
                                width: .5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Color(0xffF6C259).withOpacity(.41),
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
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        _pancheckPermission();
                      },
                      child: Container(
                          width: width * .7,
                          height: height * .15,
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    color: Color(0xff656262),
                                    blurRadius: 3,
                                    spreadRadius: .01),
                              ],
                              color: Color(0xff1B1B1B),
                              borderRadius: BorderRadius.circular(10)),
                          child: _panimage != null
                              ? GestureDetector(
                                  onTap: () {
                                    _pancheckPermission();
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      _panimage!.absolute,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                )
                              : pancard != ""
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        "$pancard",
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Spacer(),
                                        Image.asset(
                                          'images/uploadicon.png',
                                          height: 20,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Upload pan Image',
                                          style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 14,
                                              color: whiteColor,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        Spacer(),
                                      ],
                                    )),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isLoading = true;
                        });
                        _submitForm();
                      },
                      child: isLoading
                          ? CircularProgressIndicator(color: whiteColor)
                          : Container(
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
                                          text: ' Details',
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
                    Spacer(),
                  ],
                )),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future _getAdharImage() async {
    final ImagePicker _picker = ImagePicker();
    var image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 400,
      maxHeight: 400,
      imageQuality: 50,
    );
    if (image != null) {
      setState(() {
        _image = File(image.path);
        print("my img is $_image");
        print(_image!.lengthSync());
      });
    }
  }

  Future _getAdharbackImage() async {
    final ImagePicker _picker = ImagePicker();
    var image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 400,
      maxHeight: 400,
      imageQuality: 50,
    );
    if (image != null) {
      setState(() {
        _adharimage = File(image.path);
        print("my img is $_image");
        print(_image!.lengthSync());
      });
    }
  }

  Future _getPanImage() async {
    final ImagePicker _picker = ImagePicker();
    var image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 400,
      maxHeight: 400,
      imageQuality: 50,
    );
    if (image != null) {
      setState(() {
        _panimage = File(image.path);
        print("my img is $_panimage");
        print(_panimage!.lengthSync());
      });
    }
  }

  void _checkPermission() async {
    final permission = Permission.camera;
    final status = await permission.status;
    if (status == PermissionStatus.granted) {
      _getAdharImage();
    } else {
      await permission.request();
    }
  }

  void _checkadharPermission() async {
    final permission = Permission.camera;
    final status = await permission.status;
    if (status == PermissionStatus.granted) {
      _getAdharbackImage();
    } else {
      await permission.request();
    }
  }

  void _pancheckPermission() async {
    final permission = Permission.camera;
    final status = await permission.status;
    if (status == PermissionStatus.granted) {
      _getPanImage();
    } else {
      await permission.request();
    }
  }

  bool checkFileSize(String path) {
    var fileSizeLimit = 2.5 * 1024 * 1024; // 2.5MB in bytes
    File f = File(path);
    var s = f.lengthSync();
    print(s); // returns in bytes

    if (s > fileSizeLimit) {
      print("File size greater than the limit");
      return false;
    } else {
      print("file can be selected");
      return true;
    }
  }
}
