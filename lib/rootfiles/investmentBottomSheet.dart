// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:evencross/paymentmethod/paymentmethod.dart';
import 'package:evencross/reusablewidget/colors.dart';
import 'package:flutter/material.dart';

class InvestmentHistory extends StatefulWidget {
  const InvestmentHistory({super.key, required this.username});
  final String username;

  @override
  State<InvestmentHistory> createState() => _InvestmentHistoryState();
}

class _InvestmentHistoryState extends State<InvestmentHistory> {
  late List<dynamic> _results = [];

  Future<dynamic> getData(String username, String key) async {
    http.Response response = await http.get(Uri.parse(
      'https://evencross.online/dashboard/userapi/investment_history/$username/$key',
    ));
    if (response.statusCode == 200) {
      Map<String, dynamic> decodedData = json.decode(response.body);
      final status = decodedData['status'];
      if (status == 'success') {
        List<dynamic> data = decodedData["investment_history"];

        setState(() {
          _results = decodedData["investment_history"];
        });
      }
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData(widget.username, '818c56d73cc197fe899de713748b92dbed1a3f24');
  }

  @override
  Widget build(BuildContext context) {
    ScrollController listScrollController = ScrollController();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    bool isTapped = false;
    int selectedindex = 0;
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff050505),
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: height * .04,
          ),
          Text(
            'Investment History',
            style: TextStyle(
                color: whiteColor,
                fontFamily: 'Poppins',
                fontSize: 20,
                letterSpacing: 1.4,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: height * .03,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * .01),
            child: Container(
              width: width,
              height: height * .05,
              decoration: BoxDecoration(
                  color: Color(0xff1F1F1F),
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Name'.toUpperCase(),
                        style: TextStyle(
                            color: Color(0xffD9D9D9),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'date'.toUpperCase(),
                        style: TextStyle(
                            color: Color(0xffD9D9D9),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'amount'.toUpperCase(),
                        style: TextStyle(
                            color: Color(0xffD9D9D9),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold),
                      ),
                      // Text(
                      //   'refno'.toUpperCase(),
                      //   style: TextStyle(
                      //       color: Color(0xffD9D9D9),
                      //       fontFamily: 'Poppins',
                      //       fontWeight: FontWeight.bold),
                      // ),
                      Text(
                        'status'.toUpperCase(),
                        style: TextStyle(
                            color: Color(0xffD9D9D9),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'remarks'.toUpperCase(),
                        style: TextStyle(
                            color: Color(0xffD9D9D9),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold),
                      )
                    ]),
              ),
            ),
          ),
          SizedBox(
            height: height * .01,
          ),
          Container(
            height: height * .33,
            child: ListView.builder(
                shrinkWrap: true,
                controller: listScrollController,
                // physics: AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: _results.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Container(
                        height: height * .1,
                        width: width,
                        color: Color(0xff1F1F1F),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    // color: Colors.amber,
                                    // width: width * .3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          _results[index]['name'],
                                          style: TextStyle(
                                              color: whiteColor,
                                              fontFamily: 'Poppins',
                                              fontSize: 12),
                                        ),
                                        Container(
                                          width: width * .3,
                                          height: height * .03,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: RichText(
                                              text: TextSpan(
                                                  text: 'Date',
                                                  style: TextStyle(
                                                    letterSpacing: 1.2,
                                                    color: whiteColor,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          ':  ${_results[index]['entry_date']}',
                                                      style: TextStyle(
                                                        letterSpacing: 1.2,

                                                        color: whiteColor,
                                                        fontFamily: 'Poppins',
                                                        fontSize: 12,
                                                        //height: 1.7,
                                                      ),
                                                    ),
                                                  ]),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * .05,
                                    child: VerticalDivider(
                                      color: Color(0xffE2D2B1),
                                      thickness: 1,
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: width * .15,
                                        height: height * .03,
                                        child: Center(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: RichText(
                                              text: TextSpan(
                                                  text: 'Rs ',
                                                  style: TextStyle(
                                                    letterSpacing: 1.4,
                                                    color: Color(0xffF9D296),
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'Poppins',
                                                    fontSize: 8,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text: _results[index]
                                                          ['amount'],
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xffF9D296),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily: 'Poppins',
                                                        fontSize: 14,
                                                        //height: 1.7,
                                                      ),
                                                    ),
                                                  ]),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // Text(
                                      //   'REFID${_results[index]['ref']}',
                                      //   style: TextStyle(
                                      //       color: whiteColor,
                                      //       fontFamily: 'Poppins',
                                      //       fontSize: 12),
                                      // ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * .05,
                                    child: VerticalDivider(
                                      color: Color(0xffE2D2B1),
                                      thickness: 1,
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          text: '${_results[index]['status']}'
                                              .toUpperCase(),
                                          style: TextStyle(
                                            letterSpacing: 1.4,
                                            color: whiteColor,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Poppins',
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                            Padding(
                              padding: EdgeInsets.only(left: width * .05),
                              child: Container(
                                child: RichText(
                                  text: TextSpan(
                                      text: 'REMARKS : ',
                                      style: TextStyle(
                                          color: Color(0xffF6C259),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Poppins'),
                                      children: [
                                        TextSpan(
                                          text: _results[index]['remark'],
                                          style: TextStyle(
                                            color: Color(0xffF9D296),
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                            //height: 1.7,
                                          ),
                                        ),
                                      ]),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                            height: height * .01,
                            width: width,
                            decoration: BoxDecoration(
                                gradient: index.isEven
                                    ? LinearGradient(
                                        colors: [
                                            Color(0xffF6C259),
                                            Color(0xff000000),
                                          ],
                                        begin: Alignment.centerRight,
                                        end: Alignment.centerLeft)
                                    : LinearGradient(
                                        colors: [
                                            Color(0xff000000),
                                            Color(0xffF6C259),
                                          ],
                                        begin: Alignment.centerRight,
                                        end: Alignment.centerLeft))),
                      )
                    ],
                  );
                }),
          ),
          SizedBox(
            height: height * .03,
          ),
        ],
      ),
    );
  }
}
