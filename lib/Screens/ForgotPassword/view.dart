import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Constants/Colors.dart';
import '../../Presentation/common_button.dart';
import '../../Presentation/textfeild_validation.dart';
import '../ForgotPasswordOtp/view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../Registration/view.dart';


class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  String? phoneNumber, verificationId;
  late String otp, authStatus = "";
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isloading = false;


  Future<void> verifyPhoneNumber(BuildContext context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91" + phoneNumber!,
      timeout: const Duration(minutes: 1),
      verificationCompleted: (AuthCredential authCredential) {
        setState(() {
          authStatus = "Your account is successfully verified";
        });
      },
      verificationFailed: (FirebaseAuthException authException) {
        setState(() {
          authStatus = "Authentication failed";
        });
      },
      codeSent: (String verId, [int]) {
        verificationId = verId;
        print("veri::::$verificationId");
        setState(() {
          //  authStatus = "OTP has been successfully send";
        });
        isloading
            ? Center(
            child: CircularProgressIndicator(
              backgroundColor: appColor,
            ))
            :
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) { return ForgotPasswordOtpPage(verificationId!, phoneNumber); },
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verId) {
        verificationId = verId;
        setState(() {
          authStatus = "TIMEOUT";
        });
      },
    );
  }


  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isVisibleV = false;


  void showWidget() {
    setState(() {
      isVisibleV = !isVisibleV;
    });
  }

  late String token;

  @override
  void initState() {
    getToken();
    // TODO: implement initState
    super.initState();
  }


  getToken() async {
    token = (await FirebaseMessaging.instance.getToken())!;
    print("token $token");
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Stack(
      children: [

        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              image: AssetImage("assets/images/login_bg.png"),
              // colorFilter: ColorFilter.mode(Colors.black, BlendMode.color),
              fit: BoxFit.cover,
            ),
          ),

        ),

        Scaffold(
          backgroundColor: Colors.transparent,
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
                      height: ScreenUtil().setHeight(20),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'We will send OTP to your registered mobile number. Please enter that to reset your password.', style: TextStyle(
                        color: secondaryColor,
                        fontSize: ScreenUtil().setWidth(14),
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w800,
                      ),),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(35),
                    ),
                    Container(
                      height: ScreenUtil().setHeight(105),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Enter registered mobile number', style: TextStyle(
                                color: secondaryColor,
                                fontSize: ScreenUtil().setWidth(12),
                                fontFamily: 'poppins',
                                fontWeight: FontWeight.w100,
                              ),),
                            ],
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(5),
                          ),
                          Container(
                            //   height: ScreenUtil().setHeight(45),
                            width: ScreenUtil().setWidth(320),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(color: inactiveColor, width: 0.0)
                            ),
                            child: TextFormField(
                              // textAlign: TextAlign.start,
                              keyboardType: TextInputType.number,
                              textAlignVertical: TextAlignVertical.center,
                              controller: _emailController,
                              style: TextStyle(
                                  fontFamily: 'railway',
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: primaryColor
                              ),
                              onChanged: (value) {
                                phoneNumber = value;
                                print(phoneNumber);
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                //  contentPadding: EdgeInsets.only(left: 20.0, top: 20.0, bottom: 20.0, right: 20.0),
                                isDense: true,
                                hintText: 'Enter Mobile Number',
                                hintStyle: TextStyle(
                                    fontFamily: 'railway',
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: primaryTextColor),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: inactiveColor,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                    color: inactiveColor,
                                    width: 1.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: inactiveColor, width: 0.0),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            ),
                          ),
                          /*Container(
                            height: ScreenUtil().setHeight(75),
                            child: TextFieldWidgetValidation(
                              controller: _emailController,
                              title: "Mobile Number",
                              onChanged: (value) {
                                phoneNumber = value;
                                print(phoneNumber);
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field is required';
                                } else if (!RegExp(
                                    r'(^(?:[+0]9)?[0-9]{10,12}$)')
                                    .hasMatch(_emailController.text)) {
                                  return 'Invalid Mobile Number';
                                }
                                return null;
                              },
                            ),
                          ),*/
                        ],
                      ),
                    ),

                  /*  GestureDetector(
                        onTap: (){
                          setState(() {
                            if (_formKey.currentState!.validate()) {

                              if (_emailController.text.isNotEmpty) {

                                setState(() {
                                  isloading = true;
                                });
                                 Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ForgotPasswordOtpPage();
                              },
                            ),
                          );
                              } else {

                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                  Text('Please fill in the required field.'),
                                ),
                              );
                            }
                          });

                        },
                        child: RoundedButton(text: 'Send OTP', press: (){},color: appColor,)),*/
                    isVisibleV ?
                    Visibility(
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      visible: isVisibleV,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Sending OTP.....', style: TextStyle(
                          color: appColor,
                          fontSize: ScreenUtil().setHeight(12),
                          fontFamily: 'railway',
                          fontWeight: FontWeight.normal,
                        ),),
                      ),
                    ) : Container(),

                    SizedBox(
                      height: 20,
                    ),

                    Center(
                      child: Text(
                        authStatus == "fail" ? "" : authStatus,
                        style: TextStyle(
                            color: authStatus.contains("fail") ||
                                authStatus.contains("TIMEOUT")
                                ? Colors.red
                                : Colors.green),
                      ),
                    ),

                    SizedBox(
                      height: ScreenUtil().setHeight(80),
                    ),

                    isloading
                        ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: appColor,
                        ))
                        :
                    GestureDetector(
                      onTap: () {
                        phoneNumber != null ? showWidget() : "";
                        phoneNumber == null ? Message(context, "Please Enter Moboile Number") : verifyPhoneNumber(context);
                        verificationId == null ? " Please verify contact number" :

                        print("verificationId::::$verificationId");
                      },
                      child: RoundedButton(
                        text: "Proceed Securely",
                        press: () {

                        },
                      ),
                    ),


                    SizedBox(
                      height: ScreenUtil().setHeight(15),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}