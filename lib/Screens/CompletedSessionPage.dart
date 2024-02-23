import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poker_income/Model/GetAddSessionData.dart';
import '../Constants/Colors.dart';
import 'package:http/http.dart';
import 'dart:convert';
import '../Constants/Api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompletedSessionPage extends StatefulWidget {
  const CompletedSessionPage({Key? key}) : super(key: key);

  @override
  State<CompletedSessionPage> createState() => _CompletedSessionPageState();
}

class _CompletedSessionPageState extends State<CompletedSessionPage> {

  bool isloading = false;
  SharedPreferences ?prefs;
  late GetAddSessionData getAddSessionData;
  List<SessionList>? sessionList = [];

  @override
  void initState() {
    super.initState();
    getSessionsList();
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
          "Cash Game",
          style: TextStyle(
            color: appColor,
            fontSize: ScreenUtil().setWidth(18),
            fontFamily: 'poppins',
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body:isloading
          ? Center(
        child: CircularProgressIndicator(
          color: appColor,
        ),
      )
          : SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            left: ScreenUtil().setWidth(10),
            right: ScreenUtil().setWidth(10),
            top: ScreenUtil().setHeight(15),
            bottom: ScreenUtil().setHeight(15)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: primaryTextColor, width: 0.2)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:EdgeInsets.only(
                            bottom: ScreenUtil().setHeight(10), 
                            left: ScreenUtil().setWidth(10),
                            right: ScreenUtil().setWidth(10),
                            top: ScreenUtil().setHeight(5)),
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
                                        'Buyin/Tips',
                                        style: TextStyle(
                                          color: appColor,
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
                                            '₹ 0.00/₹ 0.00',
                                            style: TextStyle(
                                              color: lightTextColor,
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
                        padding:EdgeInsets.only(
                            bottom: ScreenUtil().setHeight(10),
                            left: ScreenUtil().setWidth(10),
                            right: ScreenUtil().setWidth(10),
                            top: ScreenUtil().setHeight(5)),
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
                                        'Note',
                                        style: TextStyle(
                                          color: appColor,
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
                                            '',
                                            style: TextStyle(
                                              color: lightTextColor,
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
                        padding:EdgeInsets.only(
                            bottom: ScreenUtil().setHeight(10),
                            left: ScreenUtil().setWidth(10),
                            right: ScreenUtil().setWidth(10),
                            top: ScreenUtil().setHeight(5)),
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
                                        'Start',
                                        style: TextStyle(
                                          color: appColor,
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
                                            '09/02/24 9:20 AM',
                                            style: TextStyle(
                                              color: lightTextColor,
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
                        padding:EdgeInsets.only(
                            bottom: ScreenUtil().setHeight(10),
                            left: ScreenUtil().setWidth(10),
                            right: ScreenUtil().setWidth(10),
                            top: ScreenUtil().setHeight(5)),
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
                                        'End',
                                        style: TextStyle(
                                          color: appColor,
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
                                            '09/02/24 5:20 PM',
                                            style: TextStyle(
                                              color: lightTextColor,
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
                        padding:EdgeInsets.only(
                            bottom: ScreenUtil().setHeight(10),
                            left: ScreenUtil().setWidth(10),
                            right: ScreenUtil().setWidth(10),
                            top: ScreenUtil().setHeight(5)),
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
                                        'Cashed Out',
                                        style: TextStyle(
                                          color: appColor,
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
                                              color: lightTextColor,
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
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future<void> getSessionsList() async {
    prefs = await SharedPreferences.getInstance();
    //print((int.parse(bidValueController.text)*100)/int.parse(contestPrice));
    setState(() {
      isloading = true;
    });
    var uri = Uri.https(
      apiBaseUrl,
      '/api/getsession',
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
    print("My Add Session Response::$responseBody");
    if (statusCode == 200) {
      if (getdata["success"]) {
        getAddSessionData = GetAddSessionData.fromJson(jsonDecode(responseBody));
        sessionList!.addAll(getAddSessionData.data!);
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
