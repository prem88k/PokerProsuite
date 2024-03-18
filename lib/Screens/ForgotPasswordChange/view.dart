import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poker_income/Screens/Login/view.dart';
import '../../Constants/Api.dart';
import '../../Constants/Colors.dart';
import '../IntroductionScreen/view.dart';
import '../../Presentation/common_button.dart';
import '../../Presentation/textfeild_validation.dart';
import '../Registration/view.dart';

class ForgotPasswordChangePage extends StatefulWidget {
  String? phoneNumber;
  ForgotPasswordChangePage(this.phoneNumber);

  @override
  State<ForgotPasswordChangePage> createState() =>
      _ForgotPasswordChangePageState();
}

class _ForgotPasswordChangePageState extends State<ForgotPasswordChangePage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cPasswordController = TextEditingController();

  bool isVisibleV = false;
  bool isloading = false;
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
    //token = (await FirebaseMessaging.instance.getToken())!;
    //print("token $token");
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
                margin: EdgeInsets.only(
                    left: ScreenUtil().setWidth(30),
                    right: ScreenUtil().setWidth(30)),
                child: Column(
                  children: [
                    Container(
                      height: ScreenUtil().setHeight(200),
                      padding: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
                      alignment: Alignment.center,
                      child: Image(
                        image: AssetImage("assets/images/plogo.png"),
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
                        'OTP Verified Successfully! Enter new Password.',
                        style: TextStyle(
                          color: secondaryColor,
                          fontSize: ScreenUtil().setWidth(14),
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(35),
                    ),
                    Container(
                      height: ScreenUtil().setHeight(175),
                      child: Column(
                        children: [

                          SizedBox(
                            height: ScreenUtil().setHeight(5),
                          ),
                          Container(
                            height: ScreenUtil().setHeight(75),
                            child: TextFieldWidgetValidation(
                              controller: _passwordController,
                              title: "Password",
                              isPassword: true,
                              obs: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password is required';
                                } else if (value.length < 8 || value.length > 20) {
                                  return 'Password must be between 8 and 20 characters';
                                } else if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
                                  return 'Password must contain at least 1 lowercase letter';
                                } else if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
                                  return 'Password must contain at least 1 uppercase letter';
                                } else if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
                                  return 'Password must contain at least 1 number';
                                } else if (!RegExp(r'(?=.*[@&])').hasMatch(value)) {
                                  return 'Password must contain at least 1 special character (@ or &)';
                                }
                                return null; // Return null if the input is valid
                              },
                            ),
                          ),
                          Container(
                            height: ScreenUtil().setHeight(75),
                            child: TextFieldWidgetValidation(
                              controller: _cPasswordController,
                              title: "Confirm Password",
                              isPassword: true,
                              obs: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                } else if (value != _passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null; // Return null if the input is valid
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_formKey.currentState!.validate()) {
                              // Check additional conditions, such as non-empty text fields
                              if (_passwordController.text.isNotEmpty &&
                                  _cPasswordController.text.isNotEmpty
                              ) {
                                // Validation passed, initiate the login
                                setState(() {
                                  isloading = true;
                                });
                                forgotPasswordAPI();
                              } else {
                                // Show an error message for empty text fields
                              }
                            } else {
                              // Validation failed, show an error message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                  Text('Please fill in the required field.'),
                                ),
                              );
                            }
                          });


                        },
                        child: RoundedButton(
                          text: 'Change Password',
                          press: () {},
                          color: appColor,
                        )),
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

  Future<void> forgotPasswordAPI() async {
    setState(() {
      isloading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uri = Uri.https(
      apiBaseUrl,
      '/api/forgetpassword',
    );
    final headers = {'Accept': 'application/json'};

    Map<String, dynamic> body = {
      'mobile': widget.phoneNumber,
      'password': _cPasswordController.text,
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
    print("Forgot Password Response::$responseBody");
    if (statusCode == 500) {
      if (getdata["success"]) {
        setState(() {
          isloading = false;
        });

        Message(context, "Password Change Successfully");

        Future.delayed(const Duration(milliseconds: 1000), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return  LoginPage();
              },
            ),
          );
        });
      } else {
        setState(() {
          isloading = false;
        });
        Message(context, getdata["data"]["message"]);
      }
    } else {
      setState(() {
        isloading = false;
      });
      Message(context, getdata["message"]);
    }
  }
}
