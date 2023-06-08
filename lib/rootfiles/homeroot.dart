import 'package:evencross/reusablewidget/colors.dart';
import 'package:evencross/rootfiles/accountsection.dart';
import 'package:evencross/rootfiles/homesection.dart';
import 'package:flutter/material.dart';

class Homeroot extends StatefulWidget {
  const Homeroot({
    required this.username,
    required this.totalIncome,
    required this.totalRefferals,
    required this.commision,
    required this.totalInvestment,
    required this.monthlyProfit,
    required this.totalWithdrawal,
    required this.balance,
    required this.password,
    required this.name,
  });
  final String username;
  final String name;
  final int totalIncome;
  final int totalRefferals;
  final int balance;
  final int monthlyProfit;
  final int totalWithdrawal;
  final int totalInvestment;
  final int commision;
  final String password;

  @override
  State<Homeroot> createState() => _HomerootState();
}

class _HomerootState extends State<Homeroot> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: blackcolor,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Stack(alignment: Alignment.bottomCenter, children: [
                Container(
                  width: width,
                  height: height,
                  child: _currentIndex == 0
                      ? HomeSection(
                          username: widget.username,
                          income: widget.totalIncome,
                          refferal: widget.totalRefferals,
                          commision: widget.commision,
                          balance: widget.balance,
                          withdrawal: widget.totalWithdrawal,
                          monthlyprofit: widget.monthlyProfit,
                          investment: widget.totalInvestment)
                      : AccountSection(
                          username: widget.username,
                          password: widget.password,
                          name: widget.name),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Container(
                    width: width * .5,
                    height: height * .09,
                    decoration: BoxDecoration(
                        color: greycolor,
                        borderRadius: BorderRadius.circular(100)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _currentIndex = 0;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Spacer(),
                              Image.asset(
                                'images/home.png',
                                height: height * .035,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "HOME",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: _currentIndex == 0 ? gold : whiteColor,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _currentIndex = 1;
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Spacer(),
                              Image.asset(
                                'images/mapicon.png',
                                height: height * .035,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "ACCOUNT",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: _currentIndex == 1 ? gold : whiteColor,
                                ),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                )
              ])
            ],
          ),
        ],
      ),
    );
  }
}
