import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../Constants/Colors.dart';


class TextFieldWidgetValidation extends StatefulWidget {
  final String title;
  bool obs;
  bool isPassword;
  bool isReadOnly;
  final String? Function(String?) validator;
  final TextEditingController controller;
  Color borderColor;
  TextFieldWidgetValidation({
    required this.title,
    required this.controller,
    required this.validator,
    this.obs = false,
    this.isPassword=false,
    this.isReadOnly=false,

    this.borderColor=inactiveColor,
  });
  @override
  State<TextFieldWidgetValidation> createState() => _TextFieldWidgetValidationState();
}

class _TextFieldWidgetValidationState extends State<TextFieldWidgetValidation> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(0),
          vertical:ScreenUtil().setHeight(5)
      ),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Container(
          height:  widget.title=="What is your concern?"? ScreenUtil().setHeight(85):ScreenUtil().setHeight(45),
          child: TextFormField(
            maxLines: widget.title== "What is your concern?"?5:1,
            minLines: widget.title=="What is your concern?"?5:1,
            textAlignVertical: TextAlignVertical.center,
            style: TextStyle(
              fontSize: ScreenUtil().setWidth(12.5),
              color: widget.title=="Search Here"?secondaryColor: primaryTextColor,
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

                  print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);

                  print(
                      formattedDate); //formatted date output using intl package =>  2021-03-16
                  setState(() {
                    widget.controller.text =
                        formattedDate; //set output date to TextField value.
                  });
                } else {}
              }

            },
            validator: widget.validator,
            decoration: !widget.isPassword?
            InputDecoration(
              contentPadding:EdgeInsets.symmetric(horizontal: 0, vertical: 0) ,
              errorStyle: TextStyle(
                fontSize: ScreenUtil().setWidth(12.5),
                color: Colors.red,
                fontFamily: 'poppins',
              ),
              prefix: SizedBox(width: 10),
              fillColor: widget.title=="Search Here"?Colors.transparent:inactiveColor,
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.title=="Search Here"?secondaryColor: primaryColor,
                  width: 1.0,

                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ScreenUtil().setWidth(5)),
                borderSide: BorderSide(
                  color: widget.title=="Search Here"?secondaryColor: inactiveColor,
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
                color: widget.title=="Search Here"?secondaryColor: lightTextColor,
                fontFamily: 'poppins',
              ),
            )
                :InputDecoration(
              contentPadding:EdgeInsets.symmetric(horizontal: 0, vertical: 0) ,
              errorStyle: TextStyle(
                fontSize: ScreenUtil().setWidth(12.5),
                color: Colors.red,
                fontFamily: 'poppins',
              ),
              prefix: SizedBox(width: 10),
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
            ),
          ),
        ),
      ),
    );
  }
}