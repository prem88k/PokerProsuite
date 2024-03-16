import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poker_income/Screens/AddSessionDetailsPage.dart';
import 'package:poker_income/Screens/CompletedSessionPage.dart';
import 'package:poker_income/Screens/HostPage.dart';
import 'package:poker_income/Screens/Login/view.dart';
import 'package:poker_income/Screens/ReportsPage.dart';
import '../Constants/Colors.dart';
import 'NotificationPage.dart';
import 'ProfilePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences prefs;

  @override
  void initState() {
    getPreferences();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0,
        backgroundColor: secondaryColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Game",
          style: TextStyle(
            color: appColor,
            fontSize: ScreenUtil().setWidth(18),
            fontFamily: 'poppins',
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ProfilePage();
                      },
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(right: ScreenUtil().setWidth(15)),
                  child: Icon(
                    Icons.person,
                    color: appColor,
                    size: ScreenUtil().setHeight(20),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return NotificationPage();
                      },
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(right: ScreenUtil().setWidth(15)),
                  child: Icon(
                    Icons.notification_add,
                    color: appColor,
                    size: ScreenUtil().setHeight(20),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (prefs != null || prefs != "null") {
                    prefs.setBool('isLogging', false);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(right: ScreenUtil().setWidth(15)),
                  child: Icon(
                    Icons.logout,
                    color: appColor,
                    size: ScreenUtil().setHeight(20),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return AddSessionDetailsPage();
                      },
                    ),
                  );
                },
                child: Container(
                  height: ScreenUtil().setHeight(50),
                  color: secondaryColor,
                  child: Center(
                    child: Text(
                      'Add a live session',
                      style: TextStyle(
                        color: appColor,
                        fontSize: ScreenUtil().setWidth(14),
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return /*AddSessionDetailsPage*/CompletedSessionPage();
                      },
                    ),
                  );
                },
                child: Container(
                  height: ScreenUtil().setHeight(50),
                  color: secondaryColor,
                  child: Center(
                    child: Text(
                      'Add a completed session',
                      style: TextStyle(
                        color: appColor,
                        fontSize: ScreenUtil().setWidth(14),
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ReportsPage();
                      },
                    ),
                  );
                },
                child: Container(
                  height: ScreenUtil().setHeight(50),
                  color: secondaryColor,
                  child: Center(
                    child: Text(
                      'Reports',
                      style: TextStyle(
                        color: appColor,
                        fontSize: ScreenUtil().setWidth(14),
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return HostPage();
                      },
                    ),
                  );
                },
                child: Container(
                  height: ScreenUtil().setHeight(50),
                  color: secondaryColor,
                  child: Center(
                    child: Text(
                      'Host Game',
                      style: TextStyle(
                        color: appColor,
                        fontSize: ScreenUtil().setWidth(14),
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

}
