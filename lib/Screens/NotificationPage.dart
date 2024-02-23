import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Constants/Colors.dart';
import '../Constants/Api.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
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

              /*gamesList!.length == 0 ?
              Center(
                child: Text(
                  "My Games Not Found",
                  style: TextStyle(
                    color: appColor,
                    fontSize: ScreenUtil().setHeight(12),
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ):*/ ListView.builder(
                itemCount: 2,
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
                                   "ABC",
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setWidth(15),
                                      color: appColor,
                                      fontFamily: 'poppins',
                                      fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(5),
                        ),
                        Container(
                          width: ScreenUtil().setWidth(235),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: ScreenUtil().setWidth(115),
                                decoration: BoxDecoration(
                                  color: appColor,
                                  borderRadius: BorderRadius.circular(15)
                                ),
                                alignment: Alignment.topLeft,
                                child: Text(
                                     "Accept",
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setWidth(12),
                                        color: appColor,
                                        fontFamily: 'poppins',
                                        fontWeight: FontWeight.w600)),
                              ),
                              Container(
                                width: ScreenUtil().setWidth(115),
                                alignment: Alignment.topLeft,
                                child: Text(
                                    "Reject",
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setWidth(12),
                                        color: appColor,
                                        fontFamily: 'poppins',
                                        fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                        ),
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
}
