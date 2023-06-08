import 'package:evencross/loginpage/loginpopup.dart';
import 'package:evencross/reusablewidget/colors.dart';
import 'package:evencross/signuppage/signuppage.dart';
import 'package:flutter/material.dart';

class Login_Signup_Popup extends StatefulWidget {
  const Login_Signup_Popup({Key? key}) : super(key: key);

  @override
  State<Login_Signup_Popup> createState() => _Login_Signup_PopupState();
}

class _Login_Signup_PopupState extends State<Login_Signup_Popup> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: height * .45,
      decoration: const BoxDecoration(
          color: blackcolor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Spacer(),
        const SizedBox(
          height: 22,
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
                  return const Login_Popup();
                });
          },
          child: Image.asset(
            'images/loginbutton.png',
            height: width * .3,
            width: height * .3,
          ),
        ),
        // GestureDetector(
        //   onTap: () {
        //     showModalBottomSheet<void>(
        //         isScrollControlled: true,
        //         // context and builder are
        //         // required properties in this widget
        //         context: context,
        //         shape: const RoundedRectangleBorder(
        //           // <-- SEE HERE
        //           borderRadius: BorderRadius.vertical(
        //             top: Radius.circular(25),
        //           ),
        //         ),
        //         builder: (BuildContext context) {
        //           return const Signup_Popup();
        //         });
        //   },
        //   child: Image.asset(
        //     'images/signupbutton.png',
        //     height: width * .3,
        //     width: height * .3,
        //   ),
        // ),
        const Spacer(),
        const Text(
          "Address: Kochi, Kerala 682025 ",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w200,
            color: lightwhitecolor,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          "Email: evencross57@gmail.com",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w200,
            color: lightwhitecolor,
          ),
        ),
        const Spacer(),
      ]),
    );
  }
}
