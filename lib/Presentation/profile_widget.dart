import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Constants/Colors.dart';

class ProfileListPage extends StatelessWidget {
  final String text;
  final Function press;
  final Widget icon;
  final Color color, textColor;
  const ProfileListPage({
    required this.text,
    required this.press,
    required this.icon,
    this.color = secondaryColor,
    this.textColor = Colors.white,
  });

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: ScreenUtil().setHeight(10)
      ),
      height: ScreenUtil().setHeight(60),
      width: ScreenUtil().setWidth(470),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: secondaryColor
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
       Row(
         children: [
           Container(
               margin: EdgeInsets.only(
                   left: ScreenUtil().setWidth(10),
               ),
               height: ScreenUtil().setHeight(28),
               width: ScreenUtil().setWidth(28),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(100),
                 color: Color(0xffF7F7FC)
               ),
               child: Center(child: icon,)),
           Container(
               margin: EdgeInsets.only(
                 left: ScreenUtil().setWidth(15)
               ), 
               alignment: Alignment.topLeft,
               child: Center(child: Text(text,style: TextStyle(
                 fontSize: ScreenUtil().setHeight(12),
                 color: primaryTextColor,
                 fontFamily: 'poppins',
                 fontWeight: FontWeight.w600
               ),))),
         ],
       ),
          Container(
            margin: EdgeInsets.only(
              right: ScreenUtil().setWidth(5),
            ),
            child: Icon(Icons.arrow_forward_ios, color: appColor,
              size: ScreenUtil().setHeight(15),),
          ),
        ],
      ),
    );
  }
}
