import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../Constants/Colors.dart';


class UpdateTextFieldWidget extends StatefulWidget {
  final String title;
  bool obs;
  bool isPassword;
  bool isReadOnly;

  final TextEditingController controller;
  Color borderColor;
  UpdateTextFieldWidget({
    required this.title,
    required this.controller,
    this.obs = false,
    this.isPassword=false,
    this.isReadOnly=false,

    this.borderColor=inactiveColor,
  });
  @override
  State<UpdateTextFieldWidget> createState() => _UpdateTextFieldWidgetState();
}

class _UpdateTextFieldWidgetState extends State<UpdateTextFieldWidget> {



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(0), vertical:ScreenUtil().setWidth(5)),
      child: Container(
        height:  ScreenUtil().setHeight(45),
        child: TextFormField(
          maxLines: 1,
          textAlignVertical: TextAlignVertical.center,

          style: TextStyle(
            fontSize: ScreenUtil().setWidth(12.5),
            color: primaryTextColor,
            fontFamily: 'poppins',
          ),
          inputFormatters: [
          ],
          obscureText: widget.obs,
          controller: widget.controller,
          keyboardType: widget.title.toLowerCase() == "email"
              ? TextInputType.emailAddress
              : widget.title.toLowerCase() == "password"
              ? TextInputType.visiblePassword
              : widget.title == "Enter Mobile Number" || widget.title =="Enter OTP" || widget.title=="Company/Business Pincode" || widget.title=="Bank Number"?TextInputType.number: TextInputType.text,
          readOnly: widget.isReadOnly,
          onTap: () async {
            if(widget.isReadOnly)
            {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1940),
                  //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime(2100));

              if (pickedDate != null) {
                print(
                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                String formattedDate =
                DateFormat('yyyy-MM-dd').format(pickedDate);
                print(
                    formattedDate); //formatted date output using intl package =>  2021-03-16
                setState(() {
                  widget.controller.text =
                      formattedDate; //set output date to TextField value.
                });
              } else {}
            }

          },
          decoration: !widget.isPassword?InputDecoration(

            fillColor: inactiveColor,
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color:  primaryColor,
                width: 1.0,

              ),
            ),
            enabledBorder: OutlineInputBorder(

              borderRadius: BorderRadius.circular(ScreenUtil().setWidth(5)),
              borderSide: BorderSide(
                color:  inactiveColor,
                width: 1.0,
              ),
            ),
            suffixIcon: Image(
              image: AssetImage("assets/icons/edit_icon.png"),
              height: ScreenUtil().setHeight(5),
              width: ScreenUtil().setWidth(5),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:  BorderSide(
                  color:  inactiveColor, width: 1.0),
              borderRadius: BorderRadius.circular(ScreenUtil().setWidth(5)),
            ),
            hintText: widget.title,
            counterText: '',
            hintStyle: TextStyle(
              fontSize: ScreenUtil().setWidth(12.5),
              color: lightTextColor,
              fontFamily: 'poppins',
            ),
            contentPadding: EdgeInsets.only(left:  ScreenUtil().setWidth(20),top:  ScreenUtil().setHeight(20)),
          ):InputDecoration(
            suffixIcon:  GestureDetector(
              onTap: () {
                setState(() {
                  widget.obs = !widget.obs;
                });
              },
              child: widget.isPassword? Icon(
                widget.obs
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: lightTextColor,
              ):Container(),
            ),
            fillColor: inactiveColor,
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color:  primaryColor,
                width: 1.0,

              ),
            ),
            enabledBorder: OutlineInputBorder(

              borderRadius: BorderRadius.circular(ScreenUtil().setWidth(5)),
              borderSide: BorderSide(
                color:  inactiveColor,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:  BorderSide(
                  color:  inactiveColor, width: 1.0),
              borderRadius: BorderRadius.circular(ScreenUtil().setWidth(5)),
            ),
            hintText: widget.title,
            counterText: '',
            hintStyle: TextStyle(
              fontSize: ScreenUtil().setWidth(12.5),
              color: lightTextColor,
              fontFamily: 'poppins',
            ),
            contentPadding: EdgeInsets.only(left:  ScreenUtil().setWidth(20),top:  ScreenUtil().setHeight(20)),
          ),
        ),
      ),
    );
  }
}