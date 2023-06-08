// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:evencross/reusablewidget/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MonthlyProfit extends StatefulWidget {
  const MonthlyProfit({super.key, required this.username});
  final String username;

  @override
  State<MonthlyProfit> createState() => _MonthlyProfitState();
}

class _MonthlyProfitState extends State<MonthlyProfit> {
  late List<dynamic> _results = [];

  Future<dynamic> getData(String username, String key) async {
    http.Response response = await http.get(Uri.parse(
      'https://evencross.online/dashboard/userapi/monthly_profit/$username/$key',
    ));
    if (response.statusCode == 200) {
      Map<String, dynamic> decodedData = json.decode(response.body);
      final status = decodedData['status'];
      if (status == 'success') {
        List<dynamic> data = decodedData["monthly_profit"];
        print(data[0]["id"]);
        print(data.length);
      }

      setState(() {
        _results = decodedData["monthly_profit"];
        // final username = _results[0]['username'];
        // print(username);
      });
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
            'Monthly Profit',
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
                        'slno'.toUpperCase(),
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
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: VerticalDivider(
                          color: Color(0xffE2D2B1),
                          thickness: 1,
                        ),
                      ),
                      Text(
                        'amount'.toUpperCase(),
                        style: TextStyle(
                            color: Color(0xffD9D9D9),
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
              ),
            ),
          ),
          SizedBox(
            height: height * .01,
          ),
          Container(
            height: height * .45,
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
                        height: height * .09,
                        width: width,
                        color: Color(0xff1F1F1F),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                // color: Colors.amber,
                                // width: width * .3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                          color: whiteColor,
                                          fontFamily: 'Poppins',
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
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
                                          color: whiteColor,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                ': ${_results[index]['entry_date']}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
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
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: VerticalDivider(
                                  color: Color(0xffE2D2B1),
                                  thickness: 1,
                                ),
                              ),
                              Container(
                                width: width * .25,
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
                                              text: _results[index]['credit'],
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
                                ),
                              ),
                              // RichText(
                              //   text: TextSpan(
                              //       text: 'Rs ',
                              //       style: TextStyle(
                              //         letterSpacing: 1.4,
                              //         color: Color(0xffF9D296),
                              //         fontWeight: FontWeight.w600,
                              //         fontFamily: 'Poppins',
                              //         fontSize: 8,
                              //       ),
                              //       children: [
                              //         TextSpan(
                              //           text: '1,29,999',
                              //           style: TextStyle(
                              //             color: Color(0xffF9D296),
                              //             fontWeight: FontWeight.w600,
                              //             fontFamily: 'Poppins',
                              //             fontSize: 14,
                              //             //height: 1.7,
                              //           ),
                              //         ),
                              //       ]),
                              // ),
                            ]),
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
            height: height * .05,
          ),
        ],
      ),
    );
  }
}
