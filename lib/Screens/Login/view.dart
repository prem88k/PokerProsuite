import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poker_income/Screens/Registration/view.dart';
import '../../Constants/Api.dart';
import '../../Constants/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'dart:convert';

import '../../Presentation/common_button.dart';
import '../../Presentation/textfeild_validation.dart';
import '../BottomNavigationBar.dart';
import '../ForgotPassword/view.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
   /* _emailController.text = "8866482755";
    _passwordController.text = "Falak@123";*/
    getToken();
    // TODO: implement initState
    super.initState();
  }

  getToken() async {
    //token = (await FirebaseMessaging.instance.getToken())!;
    //print("token $token");
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String errorString = "";
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: ScreenUtil().setHeight(175),
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
                        'Login with your credentials',
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
                      height: ScreenUtil().setHeight(105),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Enter registered mobile number',
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: ScreenUtil().setWidth(12),
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(5),
                          ),
                          Container(
                            height: ScreenUtil().setHeight(75),
                            child: TextFieldWidgetValidation(
                              controller: _emailController,
                              title: "Mobile Number",
                              validator: (value) {
                                if (_emailController.text.isEmpty) {
                                  return 'This field is required';
                                } else if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                                    .hasMatch(_emailController.text)) {
                                  return 'Invalid Mobile Number';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: ScreenUtil().setHeight(105),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Enter password',
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: ScreenUtil().setWidth(12),
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ],
                          ),
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
                                if (_passwordController.text.isEmpty) {
                                  return 'This field is required';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(15),
                    ),
                    isloading
                        ? Center(
                          child: CircularProgressIndicator(
                      color: appColor,
                    ),
                        )
                        :
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_formKey.currentState!.validate()) {
                            // Check additional conditions, such as non-empty text fields
                            if (_emailController.text.isNotEmpty &&
                                _passwordController.text.isNotEmpty) {
                              // Validation passed, initiate the login
                              setState(() {
                                isloading = true;
                              });

                              LoginAPI();
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
                        text: 'Login to Account',
                        press: () {},
                        color: appColor,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(15),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ForgotPasswordPage();
                            },
                          ),
                        );
                      },
                      child: Container(
                        height: ScreenUtil().setHeight(40),
                        child: Center(
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: ScreenUtil().setWidth(12),
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(15),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return RegistrationPage();
                            },
                          ),
                        );
                      },
                      child: Container(
                        height: ScreenUtil().setHeight(40),
                        child: Center(
                          child: Text(
                            'Not Registered? Sign up now',
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: ScreenUtil().setWidth(12),
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(15),
                    ),
                   /* GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return BottomNavigationBarScreen();
                            },
                          ),
                        );
                      },
                      child: Container(
                        height: ScreenUtil().setHeight(40),
                        child: Center(
                          child: Text(
                            'SKIP',
                            style: TextStyle(
                              color: secondaryColor,
                              fontSize: ScreenUtil().setWidth(12),
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),*/
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> LoginAPI() async {
    setState(() {
      isloading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uri = Uri.https(
      apiBaseUrl,
      '/api/login',
    );
    final headers = {'Accept': 'application/json'};

    Map<String, dynamic> body = {
      'mobile': _emailController.text,
      'password': _passwordController.text,
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
    print("Login Response::$responseBody");
    if (statusCode == 200) {
      if (getdata["status"]) {
        setState(() {
          isloading = false;
        });

        Message(context, "Login Successfully");

        prefs.setString("access_token", "${getdata["token"].toString()}");
        prefs.setString("userId", "${getdata["user"][0]["id"].toString()}");
        prefs.setString("mobile", "${getdata["user"][0]["mobile"].toString()}");
        prefs.setString("name", "${getdata["user"][0]["name"].toString()}");
        prefs.setBool("isLogging", true);
        prefs.setString("token", getdata["token"].toString());

        Future.delayed(const Duration(milliseconds: 1000), () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return  BottomNavigationBarScreen();
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
