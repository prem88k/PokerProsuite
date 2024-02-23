import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Constants/Colors.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({Key? key}) : super(key: key);

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {

  int? selectedIndex;

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
                        _buildServiceList() :
                        selectedIndex == 1 ?
                        _buildweekList() :
                        selectedIndex == 2 ?
                        _buildmonthList() :
                        selectedIndex == 3 ?
                        _buildyearList() : Container()
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceList() {
    return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:EdgeInsets.only(bottom: ScreenUtil().setHeight(10), top: ScreenUtil().setHeight(10)),
          child: GestureDetector(
            onTap: () {
              /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return CompletedSessionPage();
                        },
                      ),
                    );*/
            },
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Profit/Loss',
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
                              '₹ 0:00',
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
              /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return CompletedSessionPage();
                        },
                      ),
                    );*/
            },
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          '₹/Hour',
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
                              '₹ 0:00',
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
              /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return CompletedSessionPage();
                        },
                      ),
                    );*/
            },
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          '₹/Session',
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
                              '₹ 0:00',
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
              /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return CompletedSessionPage();
                        },
                      ),
                    );*/
            },
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Duration',
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
                              '64 hour(s) 0 minute(s)',
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
              /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return CompletedSessionPage();
                        },
                      ),
                    );*/
            },
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Cashed',
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
                              '0/8 (0%)',
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
              /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return CompletedSessionPage();
                        },
                      ),
                    );*/
            },
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Tips/Meals',
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
                              '₹ 0:00',
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
              /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return CompletedSessionPage();
                        },
                      ),
                    );*/
            },
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Bankroll',
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
                              '₹ 0:00',
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

  Widget _buildweekList() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: boxBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.only(top:5.0, bottom: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      'Days',
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
                          '₹/Hour',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: ScreenUtil().setWidth(14),
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                     /* SizedBox(width: ScreenUtil().setWidth(5),),
                      Icon(Icons.arrow_forward_ios, color: primaryColor, size: ScreenUtil().setHeight(14),)*/
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding:EdgeInsets.only(bottom: ScreenUtil().setHeight(10), top: ScreenUtil().setHeight(20)),
            child: GestureDetector(
              onTap: () {
                /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return CompletedSessionPage();
                        },
                      ),
                    );*/
              },
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Monday',
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
                                '16 Hours',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: ScreenUtil().setWidth(14),
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
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
                /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return CompletedSessionPage();
                        },
                      ),
                    );*/
              },
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Tuesday',
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
                                '12 Hours',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: ScreenUtil().setWidth(14),
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
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

  Widget _buildmonthList() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: boxBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.only(top:5.0, bottom: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      'Month',
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
                          '₹/Hour',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: ScreenUtil().setWidth(14),
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      /* SizedBox(width: ScreenUtil().setWidth(5),),
                      Icon(Icons.arrow_forward_ios, color: primaryColor, size: ScreenUtil().setHeight(14),)*/
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding:EdgeInsets.only(bottom: ScreenUtil().setHeight(10), top: ScreenUtil().setHeight(20)),
            child: GestureDetector(
              onTap: () {
                /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return CompletedSessionPage();
                        },
                      ),
                    );*/
              },
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'March',
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
                                '16 Hours',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: ScreenUtil().setWidth(14),
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
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

  Widget _buildyearList() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: boxBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.only(top:5.0, bottom: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      'Year',
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
                          '₹/Hour',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: ScreenUtil().setWidth(14),
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      /* SizedBox(width: ScreenUtil().setWidth(5),),
                      Icon(Icons.arrow_forward_ios, color: primaryColor, size: ScreenUtil().setHeight(14),)*/
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding:EdgeInsets.only(bottom: ScreenUtil().setHeight(10), top: ScreenUtil().setHeight(20)),
            child: GestureDetector(
              onTap: () {
                /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return CompletedSessionPage();
                        },
                      ),
                    );*/
              },
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            '2023-2024',
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
                                '16 Hours',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: ScreenUtil().setWidth(14),
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
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
}
