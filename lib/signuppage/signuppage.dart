import 'package:evencross/reusablewidget/colors.dart';
import 'package:evencross/rootfiles/homeroot.dart';
import 'package:flutter/material.dart';

class Signup_Popup extends StatefulWidget {
  const Signup_Popup({Key? key}) : super(key: key);

  @override
  State<Signup_Popup> createState() => Signup_PopupState();
}

class Signup_PopupState extends State<Signup_Popup> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController =TextEditingController();
  TextEditingController mobileController= TextEditingController();

  int val = 1;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Container(
          height: height * .81,
          decoration: const BoxDecoration(
              color: blackcolor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          child: Padding(
            padding: EdgeInsets.only(left: width * .1, right: width * .1),
            child: Container(
              height: height * .81,
              width: width * .9,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Spacer(),
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                              text: "Signup\n",
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
                          padding: const EdgeInsets.only(left: 10, top: 20),
                          child: Image.asset(
                            'images/gradientbar.png',
                            height: width * .2,
                            width: height * .23,
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                            text: "Reference Id :",
                            style: TextStyle(
                              letterSpacing: 1,
                              color: whiteColor.withOpacity(.46),
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Poppins',
                              fontSize: 14,
                            ),
                            children: const [
                              TextSpan(
                                text: ' EC1000',
                                style: TextStyle(
                                  color: Color(0xffF6C259),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  //height: 1.7,
                                ),
                              ),
                            ]),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: width * .91,
                      height: 70,
                      child: TextField(
                        controller: emailController,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          fillColor: blackcolor,
                          filled: true,
                          prefixIcon: const Icon(
                            Icons.mail_outline,
                            color: Color(0xffF6C259),
                          ),
                          hintText: "E-mail",
                          hintStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              color: Color(0xff787878)),
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
                        controller: nameController,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          fillColor: blackcolor,
                          filled: true,
                          prefixIcon: const Icon(
                            Icons.person_outline,
                            color: Color(0xffF6C259),
                          ),
                          hintText: "Name",
                          hintStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              color: Color(0xff787878)),
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
                        controller: mobileController,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          fillColor: blackcolor,
                          filled: true,
                          prefixIcon: const Icon(
                            Icons.headphones,
                            color: Color(0xffF6C259),
                          ),
                          hintText: "Mobile No",
                          hintStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              color: Color(0xff787878)),
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
                          color: whiteColor,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Theme(
                          data: Theme.of(context).copyWith(
                            unselectedWidgetColor: whiteColor,
                          ),
                          child: Transform.scale(
                            scale: 1.5,
                            child: Radio(
                                activeColor: const Color(0XFF5A4722),
                                value: 1,
                                groupValue: val,
                                onChanged: (value) {
                                  setState(() {
                                    val = 1;
                                  });
                                }),
                          ),
                        ),
                        Text(
                          'Male',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 20,
                              color: whiteColor.withOpacity(.46),
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Theme(
                          data: Theme.of(context).copyWith(
                            unselectedWidgetColor: whiteColor,
                          ),
                          child: Transform.scale(
                            scale: 1.5,
                            child: Radio(
                                activeColor: const Color(0XFF5A4722),
                                value: 2,
                                groupValue: val,
                                onChanged: (value) {
                                  setState(() {
                                    val = 2;
                                  });
                                }),
                          ),
                        ),
                        Text(
                          'female',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 20,
                              color: whiteColor.withOpacity(.46),
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const Homeroot(
                        //               balance: ,
                        //               commision: null,
                        //               monthlyProfit: null,
                        //               totalInvestment: null,
                        //               totalIncome: null,
                        //               totalRefferals: null,
                        //               totalWithdrawal: null,
                        //               username: '',
                        //             )));
                      },
                      child: Container(
                        width: width * .9,
                        height: height * .08,
                        child: Image.asset(
                          'images/signupbutton.png',
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                    const Spacer(),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
