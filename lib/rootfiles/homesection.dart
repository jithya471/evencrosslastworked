// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:card_swiper/card_swiper.dart';
import 'package:evencross/paymentmethod/paymentmethod.dart';
import 'package:evencross/reusablewidget/colors.dart';
import 'package:evencross/rootfiles/withdraw.dart';
import 'package:evencross/rootfiles/withdrawal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'brokerageCommision.dart';
import 'directrefferal.dart';
import 'investmentBottomSheet.dart';
import 'monthlyprofit.dart';
import 'myteam.dart';
import 'package:http/http.dart' as http;

class HomeSection extends StatefulWidget {
  const HomeSection(
      {required this.username,
      required this.refferal,
      required this.monthlyprofit,
      required this.investment,
      required this.withdrawal,
      required this.balance,
      required this.commision,
      required this.income});

  final String username;
  final int refferal;
  final int monthlyprofit;
  final int investment;
  final int withdrawal;
  final int commision;
  final int income;
  final int balance;

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {
  String refer = "";
  String key = "818c56d73cc197fe899de713748b92dbed1a3f24";
  String referId = "";
  Future referEarn() async {
    http.Response response = await http.get(Uri.parse(
      'https://evencross.online/dashboard/userapi/refer/${widget.username}/$key',
    ));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      Map<String, dynamic> decodedData = json.decode(response.body);
      final status = decodedData['status'];
      if (status == "success") {
        setState(() {
          referId = jsonResponse['refer'];
        });
        print(jsonResponse);
        share();
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(status),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Close",
                  ),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool withdraw = true;
  int selectedindex = 0;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: blackcolor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: width * .085, right: width * .085),
          child: SingleChildScrollView(
            child: Container(
              width: width,
              height: height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Spacer(),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Dashboard',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 28,
                              color: whiteColor,
                              fontWeight: FontWeight.w600),
                        ),
                        GestureDetector(
                          onTap: () {
                            referEarn();
                          },
                          child: Container(
                            width: width * .37,
                            height: height * .045,
                            decoration: BoxDecoration(
                                color: Color(0xff121212),
                                borderRadius: BorderRadius.circular(100)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: whiteColor,
                                  size: 20,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Refer & Earn',
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      fontFamily: 'Montserrat',
                                      fontSize: 15,
                                      color: whiteColor,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        )
                      ]),
                  Spacer(),
                  Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        child: Stack(children: [
                          Container(
                            height: height * .23,
                            width: width,
                            child: Stack(children: [
                              Container(
                                color: blackcolor,
                                child: Image.asset(
                                  'images/orangecard.png',
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: height * .04),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: index == 0
                                                    ? 0
                                                    : width * .06),
                                            child: Text(
                                              index == 0
                                                  ? '${widget.investment}'
                                                  : '${widget.refferal}',
                                              style: TextStyle(
                                                  color: Color(0xff141414),
                                                  fontFamily: 'Poppins',
                                                  fontSize: 34,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: index == 0
                                                    ? 0
                                                    : width * .05),
                                            child: Text(
                                                index == 0
                                                    ? 'Total Investment'
                                                    : 'Withdrawal Referrals',
                                                style: TextStyle(
                                                    color: Color(0xff5F5F5F),
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        index == 0
                                            ? Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PaymentMethod(
                                                            username: widget
                                                                .username)))
                                            : WithdrawRequest(
                                                balance: widget.balance);
                                      },
                                      child: Container(
                                        width: width / 2.8,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: height * .022),
                                              child: Row(
                                                children: [
                                                  Container(
                                                      height: height * .05,
                                                      width: index == 0
                                                          ? width * .29
                                                          : width * .29,
                                                      decoration: BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: greycolor
                                                                    .withOpacity(
                                                                        .3),
                                                                offset: Offset(
                                                                    0, 4),
                                                                blurRadius: 3,
                                                                spreadRadius: 1)
                                                          ],
                                                          color: blackcolor,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          100))),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    3.0),
                                                        child: Center(
                                                          child: Text(
                                                            textAlign: TextAlign
                                                                .center,
                                                            index == 0
                                                                ? 'add investment'
                                                                    .toUpperCase()
                                                                : 'WITHDRAWAL REQUEST',
                                                            style: TextStyle(
                                                                fontSize:
                                                                    index == 0
                                                                        ? 10
                                                                        : 9,
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Color(
                                                                    0xffF7C766)),
                                                          ),
                                                        ),
                                                      )),
                                                  Icon(Icons
                                                      .keyboard_arrow_right),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ]),
                          ),
                          Positioned(
                            bottom: 0,
                            top: height * .16,
                            child: Container(
                              margin: EdgeInsets.only(left: 3),
                              width: width * .815,
                              height: height * .082,
                              decoration: BoxDecoration(
                                  color: Color(0xff141414),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15))),
                              child: Container(
                                child: Padding(
                                  padding: EdgeInsets.only(top: height * .02),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          // color: Colors.amber,
                                          // width: width / 3,
                                          child: Column(children: [
                                            RichText(
                                              text: TextSpan(
                                                  text: index == 0
                                                      ? 'Total \n'
                                                      : 'Monthly\n',
                                                  style: TextStyle(
                                                      color: Color(0xffFFFFFF)
                                                          .withOpacity(.79),
                                                      fontFamily: 'Poppins',
                                                      fontSize: 10),
                                                  children: [
                                                    TextSpan(
                                                      text: index == 0
                                                          ? "Income "
                                                          : 'Profit   ',
                                                      style: TextStyle(
                                                        color: Color(0xffFFFFFF)
                                                            .withOpacity(.79),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily: 'Poppins',
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: ' Rs',
                                                      style: TextStyle(
                                                        letterSpacing: 1.4,
                                                        color:
                                                            Color(0xffF9D296),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily: 'Poppins',
                                                        fontSize: 8,
                                                        //height: 1.7,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: index == 0
                                                          ? '${widget.income}'
                                                          : '${widget.monthlyprofit}',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xffF9D296),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily: 'Poppins',
                                                        fontSize: 13,
                                                        //height: 1.7,
                                                      ),
                                                    ),
                                                  ]),
                                            ),
                                          ]),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 9.0),
                                          child: VerticalDivider(
                                            color: Color(0xff7C7C7C),
                                            thickness: 1,
                                          ),
                                        ),
                                        Container(
                                          // color: Colors.red,
                                          // width: width / 3,
                                          child: Column(children: [
                                            RichText(
                                              text: TextSpan(
                                                  text: index == 0
                                                      ? 'Total\n'
                                                      : 'Brockerage \n',
                                                  style: TextStyle(
                                                      color: Color(0xffFFFFFF)
                                                          .withOpacity(.79),
                                                      fontFamily: 'Poppins',
                                                      fontSize: 10),
                                                  children: [
                                                    TextSpan(
                                                      text: index == 0
                                                          ? 'Withdrawal'
                                                          : "Commision ",
                                                      style: TextStyle(
                                                        color: Color(0xffFFFFFF)
                                                            .withOpacity(.79),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily: 'Poppins',
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: ' Rs',
                                                      style: TextStyle(
                                                        letterSpacing: 1.4,
                                                        color:
                                                            Color(0xffF9D296),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily: 'Poppins',
                                                        fontSize: 8,
                                                        //height: 1.7,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: index == 0
                                                          ? '${widget.withdrawal}'
                                                          : '${widget.commision}',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xffF9D296),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'Poppins',
                                                        fontSize: 12,
                                                        //height: 1.7,
                                                      ),
                                                    ),
                                                  ]),
                                            ),
                                          ]),
                                        )
                                      ]),
                                ),
                              ),
                            ),
                          ),
                        ]),
                      );
                    },
                    itemCount: 2,
                    itemWidth: width,
                    itemHeight: height * .25,
                    layout: SwiperLayout.TINDER,
                  ),
                  Spacer(),
                  SizedBox(
                    width: width * .5,
                    child: Divider(color: whiteColor),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedindex = 0;
                      });
                    },
                    child: Container(
                      width: width,
                      height: height * .15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // SizedBox(width: .0000008,),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedindex = 0;
                                  });
                                  Bottompopup();
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
                                      'images/clock.png',
                                      height: 30,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'INVESTMENT',
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
                                'HISTORY',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 10,
                                    color: whiteColor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: width * .1,
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedindex = 1;
                                    MonthlyProfitBottompopup();
                                  });
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
                                      'images/calender.png',
                                      height: 30,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'MONTHLY',
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
                                'PROFIT',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 10,
                                    color: whiteColor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: width * .1,
                          ),

                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedindex = 2;
                                    BrokerageBottompopup();
                                  });
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
                                      'images/dollar.png',
                                      height: 35,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'BROKERAGE',
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
                                'COMMISSION',
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
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedindex = 3;
                        WithdrawalRequest();
                      });
                    },
                    child: Container(
                      width: width,
                      height: height * .15,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: width * .2,
                                height: width * .2,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      selectedindex == 3
                                          ? BoxShadow(
                                              color: gold,
                                              blurRadius: 3,
                                              spreadRadius: .01)
                                          : BoxShadow(
                                              blurRadius: 3, spreadRadius: .01)
                                    ],
                                    color: Color(0xff222222),
                                    shape: BoxShape.circle),
                                child: Center(
                                  child: Image.asset(
                                    'images/files.png',
                                    height: 30,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'WITHDRAWAL',
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
                                ' REQUEST',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 10,
                                    color: whiteColor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: width * .1,
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedindex = 4;
                                    DirectRefferalBottompopup();
                                  });
                                },
                                child: Container(
                                  width: width * .2,
                                  height: width * .2,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        selectedindex == 4
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
                                      'images/copyfile.png',
                                      height: 30,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'DIRECT',
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
                                'REFERRAL',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 10,
                                    color: whiteColor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: width * .1,
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedindex = 5;
                                    MyTeamBottompopup();
                                  });
                                },
                                child: Container(
                                  width: width * .2,
                                  height: width * .2,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        selectedindex == 5
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
                                      'images/person.png',
                                      height: 30,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'MY ',
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
                                'TEAM',
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
                  SizedBox(
                    height: height * .18,
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

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
          return InvestmentHistory(username: widget.username);
        });
  }

  WithdrawRequest({required int balance}) {
    showModalBottomSheet<void>(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
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
          return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child:
                  Withdraw(username: widget.username, balance: widget.balance));
        });
  }

  MonthlyProfitBottompopup() {
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
          return MonthlyProfit(username: widget.username);
        });
  }

  BrokerageBottompopup() {
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
          return BrokerageCommision(username: widget.username);
        });
  }

  WithdrawalRequest() {
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
          return Withdrawal(username: widget.username);
        });
  }

  DirectRefferalBottompopup() {
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
          return DirectRefferal(username: widget.username);
        });
  }

  MyTeamBottompopup() {
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
          return MyTeam(username: widget.username);
        });
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        // text: 'Example share text',
        linkUrl: 'https://evencross.online/dashboard/user/register/$referId',
        chooserTitle: 'Example Chooser Title');
  }
}
