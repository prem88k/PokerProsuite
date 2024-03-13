import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poker_income/Model/GetSessionReportData.dart';
import '../Constants/Colors.dart';
import 'package:http/http.dart';
import 'dart:convert';
import '../Constants/Api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({Key? key}) : super(key: key);

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {

  int? selectedIndex;
  bool isloading = false;
  SharedPreferences ?prefs;
  late GetSessionReportData getSessionReportData;
  List<All>? allList = [];
  List<Monthly>? monthlyList = [];
  List<Yearly>? yearlyList = [];
  List<Weekly>? weeklyList = [];

  @override
  void initState() {
    super.initState();
    getReportList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        bottomOpacity: 0,
        backgroundColor: secondaryColor,
        iconTheme: IconThemeData(color: appColor),
        elevation: 1,
        centerTitle: true,
        title: Text(
          "Reports",
          style: TextStyle(
            color: appColor,
            fontSize: ScreenUtil().setWidth(18),
            fontFamily: 'poppins',
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(10.0),
            right: ScreenUtil().setWidth(10.0),
            top: ScreenUtil().setHeight(10.0),
            bottom: ScreenUtil().setHeight(10.0),
          ),
          child: Column(
            children: [
              Container(
                height: ScreenUtil().setHeight(50),
                width: ScreenUtil().screenWidth,
                decoration: BoxDecoration(
                    border:  Border(
                        top: BorderSide(color: Color(0xffE4E4EC)),
                        bottom: BorderSide(color: Color(0xffE4E4EC))
                    )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = 0;
                        });
                      },
                      child: Container(
                          width: ScreenUtil().setWidth(60),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Overall",
                                style: TextStyle(
                                    fontFamily: 'poppins',
                                    fontSize: ScreenUtil().setHeight(11),
                                    fontWeight: FontWeight.w500,
                                    color:selectedIndex == 0 ? appColor : primaryColor),
                              )
                            ],
                          )
                      ),
                    ),
                    VerticalDivider(
                      thickness: 1,
                      color: Color(0xffE4E4EC),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = 1;
                        });

                      },
                      child: Container(
                          width: ScreenUtil().setWidth(60),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Weekday",
                                style: TextStyle(
                                    fontFamily: 'poppins',
                                    fontSize: ScreenUtil().setHeight(11),
                                    fontWeight: FontWeight.w500,
                                    color: selectedIndex == 1 ? appColor : primaryColor),
                              )
                            ],
                          )),
                    ),
                    VerticalDivider(
                      thickness: 1,
                      color: Color(0xffE4E4EC),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = 2;
                        });
                      },
                      child: Container(
                          width: ScreenUtil().setWidth(60),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Month",
                                style: TextStyle(
                                    fontFamily: 'poppins',
                                    fontSize: ScreenUtil().setHeight(11),
                                    fontWeight: FontWeight.w500,
                                    color: selectedIndex == 2 ? appColor : primaryColor),
                              )
                            ],
                          )),
                    ),

                    VerticalDivider(
                      thickness: 1,
                      color: Color(0xffE4E4EC),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = 3;
                        });
                      },
                      child: Container(
                          width: ScreenUtil().setWidth(60),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Year",
                                style: TextStyle(
                                    fontFamily: 'poppins',
                                    fontSize: ScreenUtil().setHeight(11),
                                    fontWeight: FontWeight.w500,
                                    color: selectedIndex == 3 ? appColor : primaryColor),
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                      children: <Widget>[
                        selectedIndex == 0 ?
                        OverallWidget() :
                        selectedIndex == 1 ?
                        WeeklyWidget() :
                        selectedIndex == 2 ?
                        MonthlyWidget() :
                        selectedIndex == 3 ?
                        YearlyWidget() : Container()
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  OverallWidget() {
    return Container(
      padding: EdgeInsets.only(
        top: ScreenUtil().setHeight(10.0),
        bottom: ScreenUtil().setHeight(10.0),
      ),
      child: allList!.length == 0
          ? Center(
        child: Text(
          "No Data Found",
          style: TextStyle(
            color: appColor,
            fontSize: ScreenUtil().setHeight(12),
            fontFamily: 'poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
      )
          :  ListView.builder(
        itemCount: allList!.length,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, i) {
          return _buildAllList(i);
        },
      ),
    );
  }

  WeeklyWidget() {
    return Container(
      padding: EdgeInsets.only(
        top: ScreenUtil().setHeight(10.0),
        bottom: ScreenUtil().setHeight(10.0),
      ),
      child: weeklyList!.length == 0
          ? Center(
        child: Text(
          "No Data Found",
          style: TextStyle(
            color: appColor,
            fontSize: ScreenUtil().setHeight(12),
            fontFamily: 'poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
      )
          :  ListView.builder(
        itemCount: weeklyList!.length,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, i) {
          return _buildweekList(i);
        },
      ),
    );
  }

  MonthlyWidget() {
    return Container(
      padding: EdgeInsets.only(
        top: ScreenUtil().setHeight(10.0),
        bottom: ScreenUtil().setHeight(10.0),
      ),
      child: monthlyList!.length == 0
          ? Center(
        child: Text(
          "No Data Found",
          style: TextStyle(
            color: appColor,
            fontSize: ScreenUtil().setHeight(12),
            fontFamily: 'poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
      )
          :  ListView.builder(
        itemCount: monthlyList!.length,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, i) {
          return _buildmonthList(i);
        },
      ),
    );
  }

  YearlyWidget() {
    return Container(
      padding: EdgeInsets.only(
        top: ScreenUtil().setHeight(10.0),
        bottom: ScreenUtil().setHeight(10.0),
      ),
      child: yearlyList!.length == 0
          ? Center(
        child: Text(
          "No Data Found",
          style: TextStyle(
            color: appColor,
            fontSize: ScreenUtil().setHeight(12),
            fontFamily: 'poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
      )
          :  ListView.builder(
        itemCount: yearlyList!.length,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, i) {
          return _buildyearList(i);
        },
      ),
    );
  }


  Widget _buildAllList(int i) {
    return Container(
      margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10.0)),
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(10.0),
        right: ScreenUtil().setWidth(10.0),
        top: ScreenUtil().setHeight(10.0),
        bottom: ScreenUtil().setHeight(10.0),
      ),
      decoration: BoxDecoration(
          border: Border.all(color: appColor, width: 0.2),
          borderRadius: BorderRadius.circular(15), color: secondaryColor),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:EdgeInsets.only(bottom: ScreenUtil().setHeight(10), top: ScreenUtil().setHeight(10)),
          child: GestureDetector(
            onTap: () {
            },
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Cash In',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: ScreenUtil().setWidth(14),
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Text( allList![i].cashIn.toString(),
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: ScreenUtil().setWidth(14),
                                fontFamily: 'poppins',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          SizedBox(width: ScreenUtil().setWidth(5),),
                          Icon(Icons.arrow_forward_ios, color: primaryColor, size: ScreenUtil().setHeight(14),)
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: ScreenUtil().setHeight(5),),
                  Divider(
                    thickness: 0.5,
                    color: lightTextColor,
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding:EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
          child: GestureDetector(
            onTap: () {
            },
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Hour',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: ScreenUtil().setWidth(14),
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              allList![i].time.toString(),
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: ScreenUtil().setWidth(14),
                                fontFamily: 'poppins',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          SizedBox(width: ScreenUtil().setWidth(5),),
                          Icon(Icons.arrow_forward_ios, color: primaryColor, size: ScreenUtil().setHeight(14),)
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: ScreenUtil().setHeight(5),),
                  Divider(
                    thickness: 0.5,
                    color: lightTextColor,
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding:EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
          child: GestureDetector(
            onTap: () {
            },
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Cash Out',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: ScreenUtil().setWidth(14),
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              allList![i].cashOut.toString(),
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: ScreenUtil().setWidth(14),
                                fontFamily: 'poppins',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          SizedBox(width: ScreenUtil().setWidth(5),),
                          Icon(Icons.arrow_forward_ios, color: primaryColor, size: ScreenUtil().setHeight(14),)
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: ScreenUtil().setHeight(5),),
                  Divider(
                    thickness: 0.5,
                    color: lightTextColor,
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding:EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
          child: GestureDetector(
            onTap: () {

            },
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Date',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: ScreenUtil().setWidth(14),
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              allList![i].date.toString(),
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: ScreenUtil().setWidth(14),
                                fontFamily: 'poppins',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          SizedBox(width: ScreenUtil().setWidth(5),),
                          Icon(Icons.arrow_forward_ios, color: primaryColor, size: ScreenUtil().setHeight(14),)
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: ScreenUtil().setHeight(5),),
                  Divider(
                    thickness: 0.5,
                    color: lightTextColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
    );
  }

  Widget _buildweekList(int i) {
    return Container(
      margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10.0)),
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(10.0),
        right: ScreenUtil().setWidth(10.0),
        top: ScreenUtil().setHeight(10.0),
        bottom: ScreenUtil().setHeight(10.0),
      ),
      decoration: BoxDecoration(
          border: Border.all(color: appColor, width: 0.2),
          borderRadius: BorderRadius.circular(15), color: secondaryColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:EdgeInsets.only(bottom: ScreenUtil().setHeight(10), top: ScreenUtil().setHeight(10)),
            child: GestureDetector(
              onTap: () {
              },
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Cash In',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: ScreenUtil().setWidth(14),
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Text( weeklyList![i].cashIn.toString(),
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: ScreenUtil().setWidth(14),
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            SizedBox(width: ScreenUtil().setWidth(5),),
                            Icon(Icons.arrow_forward_ios, color: primaryColor, size: ScreenUtil().setHeight(14),)
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(5),),
                    Divider(
                      thickness: 0.5,
                      color: lightTextColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
            child: GestureDetector(
              onTap: () {
              },
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Hour',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: ScreenUtil().setWidth(14),
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                weeklyList![i].time.toString(),
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: ScreenUtil().setWidth(14),
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            SizedBox(width: ScreenUtil().setWidth(5),),
                            Icon(Icons.arrow_forward_ios, color: primaryColor, size: ScreenUtil().setHeight(14),)
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(5),),
                    Divider(
                      thickness: 0.5,
                      color: lightTextColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
            child: GestureDetector(
              onTap: () {
              },
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Cash Out',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: ScreenUtil().setWidth(14),
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                weeklyList![i].cashOut.toString(),
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: ScreenUtil().setWidth(14),
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            SizedBox(width: ScreenUtil().setWidth(5),),
                            Icon(Icons.arrow_forward_ios, color: primaryColor, size: ScreenUtil().setHeight(14),)
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(5),),
                    Divider(
                      thickness: 0.5,
                      color: lightTextColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
            child: GestureDetector(
              onTap: () {

              },
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Date',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: ScreenUtil().setWidth(14),
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                weeklyList![i].date.toString(),
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: ScreenUtil().setWidth(14),
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            SizedBox(width: ScreenUtil().setWidth(5),),
                            Icon(Icons.arrow_forward_ios, color: primaryColor, size: ScreenUtil().setHeight(14),)
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(5),),
                    Divider(
                      thickness: 0.5,
                      color: lightTextColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildmonthList(int i) {
    return Container(
      margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10.0)),
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(10.0),
        right: ScreenUtil().setWidth(10.0),
        top: ScreenUtil().setHeight(10.0),
        bottom: ScreenUtil().setHeight(10.0),
      ),
      decoration: BoxDecoration(
          border: Border.all(color: appColor, width: 0.2),
          borderRadius: BorderRadius.circular(15), color: secondaryColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:EdgeInsets.only(bottom: ScreenUtil().setHeight(10), top: ScreenUtil().setHeight(10)),
            child: GestureDetector(
              onTap: () {
              },
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Cash In',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: ScreenUtil().setWidth(14),
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Text( monthlyList![i].cashIn.toString(),
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: ScreenUtil().setWidth(14),
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            SizedBox(width: ScreenUtil().setWidth(5),),
                            Icon(Icons.arrow_forward_ios, color: primaryColor, size: ScreenUtil().setHeight(14),)
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(5),),
                    Divider(
                      thickness: 0.5,
                      color: lightTextColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
            child: GestureDetector(
              onTap: () {
              },
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Hour',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: ScreenUtil().setWidth(14),
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                monthlyList![i].time.toString(),
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: ScreenUtil().setWidth(14),
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            SizedBox(width: ScreenUtil().setWidth(5),),
                            Icon(Icons.arrow_forward_ios, color: primaryColor, size: ScreenUtil().setHeight(14),)
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(5),),
                    Divider(
                      thickness: 0.5,
                      color: lightTextColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
            child: GestureDetector(
              onTap: () {
              },
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Cash Out',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: ScreenUtil().setWidth(14),
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                monthlyList![i].cashOut.toString(),
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: ScreenUtil().setWidth(14),
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            SizedBox(width: ScreenUtil().setWidth(5),),
                            Icon(Icons.arrow_forward_ios, color: primaryColor, size: ScreenUtil().setHeight(14),)
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(5),),
                    Divider(
                      thickness: 0.5,
                      color: lightTextColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
            child: GestureDetector(
              onTap: () {

              },
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Date',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: ScreenUtil().setWidth(14),
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                monthlyList![i].date.toString(),
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: ScreenUtil().setWidth(14),
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            SizedBox(width: ScreenUtil().setWidth(5),),
                            Icon(Icons.arrow_forward_ios, color: primaryColor, size: ScreenUtil().setHeight(14),)
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(5),),
                    Divider(
                      thickness: 0.5,
                      color: lightTextColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildyearList(int i) {
    return Container(
      margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10.0)),
      padding: EdgeInsets.only(
        left: ScreenUtil().setWidth(10.0),
        right: ScreenUtil().setWidth(10.0),
        top: ScreenUtil().setHeight(10.0),
        bottom: ScreenUtil().setHeight(10.0),
      ),
      decoration: BoxDecoration(
          border: Border.all(color: appColor, width: 0.2),
          borderRadius: BorderRadius.circular(15), color: secondaryColor),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:EdgeInsets.only(bottom: ScreenUtil().setHeight(10), top: ScreenUtil().setHeight(10)),
            child: GestureDetector(
              onTap: () {
              },
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Cash In',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: ScreenUtil().setWidth(14),
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Text( yearlyList![i].cashIn.toString(),
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: ScreenUtil().setWidth(14),
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            SizedBox(width: ScreenUtil().setWidth(5),),
                            Icon(Icons.arrow_forward_ios, color: primaryColor, size: ScreenUtil().setHeight(14),)
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(5),),
                    Divider(
                      thickness: 0.5,
                      color: lightTextColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
            child: GestureDetector(
              onTap: () {
              },
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Hour',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: ScreenUtil().setWidth(14),
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                yearlyList![i].time.toString(),
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: ScreenUtil().setWidth(14),
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            SizedBox(width: ScreenUtil().setWidth(5),),
                            Icon(Icons.arrow_forward_ios, color: primaryColor, size: ScreenUtil().setHeight(14),)
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(5),),
                    Divider(
                      thickness: 0.5,
                      color: lightTextColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
            child: GestureDetector(
              onTap: () {
              },
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Cash Out',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: ScreenUtil().setWidth(14),
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                yearlyList![i].cashOut.toString(),
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: ScreenUtil().setWidth(14),
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            SizedBox(width: ScreenUtil().setWidth(5),),
                            Icon(Icons.arrow_forward_ios, color: primaryColor, size: ScreenUtil().setHeight(14),)
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(5),),
                    Divider(
                      thickness: 0.5,
                      color: lightTextColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
            child: GestureDetector(
              onTap: () {

              },
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Date',
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: ScreenUtil().setWidth(14),
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                yearlyList![i].date.toString(),
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: ScreenUtil().setWidth(14),
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                            SizedBox(width: ScreenUtil().setWidth(5),),
                            Icon(Icons.arrow_forward_ios, color: primaryColor, size: ScreenUtil().setHeight(14),)
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(5),),
                    Divider(
                      thickness: 0.5,
                      color: lightTextColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getReportList() async {
    prefs = await SharedPreferences.getInstance();
    //print((int.parse(bidValueController.text)*100)/int.parse(contestPrice));
    setState(() {
      isloading = true;
    });
    var uri = Uri.https(
      apiBaseUrl,
      '/api/getsessionreports',
    );

    print('${prefs!.getString('token')}');

    final encoding = Encoding.getByName('utf-8');

    final headers = {'Authorization': 'Bearer ${prefs!.getString('token')}'};

    Response response = await get(
      uri,
      headers: headers,
    );

    var getdata = json.decode(response.body);
    String responseBody = response.body;
    int statusCode = response.statusCode;
    print(getdata["success"]);
    print("My Session Report Response::$responseBody");
    if (statusCode == 200) {
      if (getdata["success"]) {
        getSessionReportData = GetSessionReportData.fromJson(jsonDecode(responseBody));
        allList!.addAll(getSessionReportData.all!);
        weeklyList!.addAll(getSessionReportData.weekly!);
        monthlyList!.addAll(getSessionReportData.monthly!);
        yearlyList!.addAll(getSessionReportData.yearly!);
        setState(() {
          isloading = false;
        });
      } else {
        setState(() {
          isloading = false;
        });
      }
    } else {
      setState(() {
        isloading = false;
      });
    }
  }
}
