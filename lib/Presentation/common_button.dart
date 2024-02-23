import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Constants/Colors.dart';


class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const RoundedButton({
    required this.text,
    required this.press,
    this.color = appColor,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width ,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(5)),
        child: Container(
            width: ScreenUtil().setWidth(150),
            height: ScreenUtil().setHeight(45),
            color: appColor,
            child: Center(child: Text(text,style: TextStyle(
              fontSize: ScreenUtil().setWidth(13),
              color: secondaryColor,
              fontFamily: 'poppins',
            ),)))
      ),
    );
  }
}
