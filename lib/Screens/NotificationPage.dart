import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poker_income/Model/GetNotificationData.dart';
import '../Constants/Colors.dart';
import '../Constants/Api.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'dart:convert';
import '../Constants/Api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Registration/view.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  bool isloading = false;
  SharedPreferences ?prefs;
  late GetNotificationData getNotificationData;
  List<NotificationList>? notificationList = [];

  @override
  void initState() {
    super.initState();
    getNotificationList();
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
          "Notification",
          style: TextStyle(
            color: appColor,
            fontSize: ScreenUtil().setWidth(18),
            fontFamily: 'poppins',
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(10.0),
            right: ScreenUtil().setWidth(10.0),
            top: ScreenUtil().setHeight(10.0),
            bottom: ScreenUtil().setHeight(10.0),
          ),
          child: Column(
            children: [
              SizedBox(
                height: ScreenUtil().setHeight(15),
              ),

              notificationList!.length == 0 ?
              Center(
                child: Text(
                  "Notification Data Not Found",
                  style: TextStyle(
                    color: appColor,
                    fontSize: ScreenUtil().setHeight(12),
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ): ListView.builder(
                itemCount: notificationList!.length,
                primary: false,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  return _buildServiceList(i);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceList(int i) {
    return Container(
      margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(10.0),
            left: ScreenUtil().setWidth(8),
            right: ScreenUtil().setWidth(8)),
        child: Container(
          width: ScreenUtil().screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: ScreenUtil().setWidth(5),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: ScreenUtil().setWidth(235),
                              alignment: Alignment.topLeft,
                              child: Text(
                                   notificationList![i].message.toString(),
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setWidth(15),
                                      color: primaryColor,
                                      fontFamily: 'poppins',
                                      fontWeight: FontWeight.w400)),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: ScreenUtil().setHeight(10),
                        ),

                        notificationList![i].status == "0" || notificationList![i].status == "1" ?
                        Container(
                          width: ScreenUtil().setWidth(235),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  requestAPI(notificationList![i].userId, notificationList![i].gameId, "0");
                                },
                                child: Container(
                                  width: ScreenUtil().setWidth(100),
                                  decoration: BoxDecoration(
                                    color: appColor,
                                    borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                           "Accept",
                                          style: TextStyle(
                                              fontSize: ScreenUtil().setWidth(12),
                                              color: secondaryColor,
                                              fontFamily: 'poppins',
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  requestAPI(notificationList![i].userId, notificationList![i].gameId, "1");
                                },
                                child: Container(
                                  width: ScreenUtil().setWidth(100),
                                  decoration: BoxDecoration(
                                      color: appColor,
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                          "Reject",
                                          style: TextStyle(
                                              fontSize: ScreenUtil().setWidth(12),
                                              color: secondaryColor,
                                              fontFamily: 'poppins',
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ) : Container(),

                        SizedBox(
                          height: ScreenUtil().setHeight(10),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getNotificationList() async {
    prefs = await SharedPreferences.getInstance();
    //print((int.parse(bidValueController.text)*100)/int.parse(contestPrice));
    setState(() {
      isloading = true;
    });
    var uri = Uri.https(
      apiBaseUrl,
      '/api/getnotification',
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
    print("Get Notification Response::$responseBody");
    if (statusCode == 200) {
      if (getdata["success"]) {
        getNotificationData = GetNotificationData.fromJson(jsonDecode(responseBody));
        notificationList!.addAll(getNotificationData.data!);
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

  Future<void> requestAPI(int? id, int? catId, String status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uri = Uri.https(
      apiBaseUrl,
      '/api/gamestatuschange',
    );
    final headers = {
      'Authorization': 'Bearer ${prefs.getString('access_token')}'
    };
    print("${id}, ${catId}, ${status}");
    Map<String, dynamic> body = {
      'user_id': id.toString(),
      'game_id': catId.toString(),
      'status': status.toString()
    };

    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      uri,
      headers: headers,
      body: body,
      encoding: encoding,
    );

    var getdata = json.decode(response.body);

    int statusCode = response.statusCode;
    String responseBody = response.body;
    print("Request Response ::$responseBody");
    if (statusCode == 200) {
      if (getdata["status"]) {
      } else {
        setState(() {
          isloading = false;
        });
        Message(context, getdata["message"]);
      }
    } else {
      setState(() {
        isloading = false;
      });
      Message(context, getdata["message"]);
    }
  }
}
