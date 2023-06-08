// ignore_for_file: prefer_const_constructors

import 'package:evencross/reusablewidget/colors.dart';
import 'package:evencross/splashscreen/login_signup_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Get_Started extends StatefulWidget {
  const Get_Started({Key? key}) : super(key: key);

  @override
  State<Get_Started> createState() => _Get_StartedState();
}

class _Get_StartedState extends State<Get_Started> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: blackcolor,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 50,
              ),
              Spacer(),
              Image.asset(
                'images/splashlogo.png',
                height: width * .55,
                width: height * .45,
              ),
              Spacer(),
              Text(
                "Invest and divest at your",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w200,
                  color: lightwhitecolor,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "convenience",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w200,
                  color: lightwhitecolor,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
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
                        return Login_Signup_Popup();
                      });
                },
                child: Image.asset(
                  'images/getstartedbutton.png',
                  height: width * .4,
                  width: height * .3,
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
