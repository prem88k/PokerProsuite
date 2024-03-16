import 'package:flutter/material.dart';
import 'package:poker_income/Model/GetMyGamesData.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Constants/Colors.dart';

class GameUserPage extends StatefulWidget {
  List<User>? user;
  GameUserPage(this.user);

  @override
  State<GameUserPage> createState() => _GameUserPageState();
}

class _GameUserPageState extends State<GameUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0,
        backgroundColor: secondaryColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "User",
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

              widget.user!.length == 0 ?
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
              ) : ListView.builder(
                itemCount: widget.user!.length,
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
    return  Container(
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(

                              width: ScreenUtil().setWidth(190),
                              alignment: Alignment.topLeft,
                              child: Text(
                                  widget.user![i].name != null ?
                                  widget.user![i].name.toString() : "ABC",
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setWidth(15),
                                      color: appColor,
                                      fontFamily: 'poppins',
                                      fontWeight: FontWeight.w600)),
                            ),
                            SizedBox(width: ScreenUtil().setWidth(5),),
                            Container(
                              height: ScreenUtil().setHeight(35),
                              width: ScreenUtil().setWidth(100),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: primaryTextColor,)
                              ),
                              alignment: Alignment.topLeft,
                              child: Center(
                                child: Text(
                                    widget.user![i].status == 0 ?
                                     "Accepted" :
                                    widget.user![i].status == 1 ?
                                    "Rejected"  :
                                    widget.user![i].status == 2 ?
                                    "Pending"  : "",
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setWidth(12),
                                        color: lightGreyColor,
                                        fontFamily: 'poppins',
                                        fontWeight: FontWeight.w600)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(5),
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
