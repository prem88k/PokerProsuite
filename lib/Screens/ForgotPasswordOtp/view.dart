import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../../Constants/Colors.dart';
import '../ForgotPasswordChange/view.dart';
import '../IntroductionScreen/view.dart';
import '../../Presentation/common_button.dart';
import '../../Presentation/textfeild_validation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../Registration/view.dart';

class ForgotPasswordOtpPage extends StatefulWidget {
  String verificationId;
  String? phoneNumber;
  ForgotPasswordOtpPage(this.verificationId, this.phoneNumber);


  @override
  State<ForgotPasswordOtpPage> createState() => _ForgotPasswordOtpPageState();
}

class _ForgotPasswordOtpPageState extends State<ForgotPasswordOtpPage> {

  bool isloading = false;
  String? otp;
  final TextEditingController _otpController = TextEditingController();

  Future<void> signIn(String otp) async {
    try {
      // Attempt to sign in with the provided OTP
      await FirebaseAuth.instance.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: widget.verificationId,
          smsCode: otp,
        ),
      );
      // If sign-in is successful, navigate to the next screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return ForgotPasswordChangePage(widget.phoneNumber);
          },
        ),
      );
    } catch (e) {
      // Handle the error
      print("Error during sign-in: $e");

      // Check if it's a specific error related to invalid verification code
      if (e is FirebaseAuthException && e.code == 'invalid-verification-code') {
        // Handle the specific error (e.g., show an error message to the user)
        Message(context,"Invalid verification code. Please check and enter the correct code.");
      } else {
        // Handle other types of errors as needed
        // You can log, show a generic error message, or take appropriate action based on the error
      }
    }
  }

  /*Future<void> signIn(String otp) async {
    await FirebaseAuth.instance
        .signInWithCredential(PhoneAuthProvider.credential(
      verificationId: widget.verificationId,
      smsCode: otp,
    ));
    setState(() {
      Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return  ForgotPasswordChangePage(widget.phoneNumber);
                              },
                            ),
                          );

    });
  }*/

  bool isVisibleV = false;

  void showWidget() {
    setState(() {
      isVisibleV = !isVisibleV;
    });
  }

  late String token;

  @override
  void initState() {
    print(widget.verificationId);
    print(widget.phoneNumber);
    getToken();
    // TODO: implement initState
    super.initState();
  }


  getToken() async {
    //token = (await FirebaseMessaging.instance.getToken())!;
    //print("token $token");
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return
       Scaffold(
          backgroundColor: secondaryColor,
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Container(
                margin: EdgeInsets.only(left:ScreenUtil().setWidth(30),right:ScreenUtil().setWidth(30)  ),
                child: Column(
                  children: [
                    Container(
                      height: ScreenUtil().setHeight(200),
                      padding: EdgeInsets.only(top:ScreenUtil().setHeight(40) ),
                      alignment: Alignment.center,
                      child: Image(image: AssetImage("assets/images/plogo.png"),
                        fit: BoxFit.cover,
                        height: ScreenUtil().setHeight(120),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(40),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'OTP', style: TextStyle(
                        color: primaryTextColor,
                        fontSize: ScreenUtil().setWidth(24),
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(15),
                    ),
                    Container(
                      height: ScreenUtil().setHeight(80),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(
                                  'Enter the OTP sent to your ${widget.phoneNumber}', style: TextStyle(
                                  color: primaryTextColor,
                                  fontSize: ScreenUtil().setWidth(13),
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.w400,
                                ),),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(10),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Enter a different Email Address', style: TextStyle(
                                color: secondaryTextColor,
                                fontSize: ScreenUtil().setWidth(12),
                                fontFamily: 'poppins',
                                fontWeight: FontWeight.w400,
                              ),),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(15),
                    ),
                    Theme(

                      data: Theme.of(context)
                          .copyWith(
                        unselectedWidgetColor:
                        inactiveColor,
                      ),
                      child: OtpTextField(
                          mainAxisAlignment: MainAxisAlignment.center,
                          numberOfFields: 6,
                          disabledBorderColor: inactiveColor,
                          enabledBorderColor: inactiveColor,
                          focusedBorderColor: appColor,
                          borderColor:inactiveColor ,
                          cursorColor: appColor,
                          textStyle: TextStyle(
                            color: primaryColor,
                            fontSize: ScreenUtil().setWidth(12),
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w400,
                          ),
                          fillColor:inactiveColor,
                          filled: true,
                          borderWidth: 1,
                          fieldWidth: ScreenUtil().setWidth(35),
                         /* onCodeChanged: (value) {
                            otp = value; },*/
                          onSubmit: (code) {
                            print("OTP is => $code");
                            _otpController.text = code;
                            otp = code;
                          } ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(15),
                    ),
                    Container(
                      height: ScreenUtil().setHeight(40),
                      child: Center(
                        child: Text(
                          'Resend OTP', style: TextStyle(
                          color: primaryTextColor,
                          fontSize: ScreenUtil().setWidth(12),
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w400,
                        ),),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(15),
                    ),
                    GestureDetector(
                        onTap: (){
                          checkValidation();
                          /*Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ForgotPasswordChangePage();
                              },
                            ),
                          );*/
                        },
                        child: RoundedButton(text: 'Submit', press: (){},color: appColor,)),

                  ],
                ),
              ),
            ),
          ),
        );

  }

  void checkValidation() {

    if (_otpController.text.isEmpty) {
      Message(context, "Enter OTP");
    }
    else {
      signIn(otp!);
    }
  }

}