import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:poker_income/Screens/BottomNavigationBar.dart';
import 'dart:convert';
import '../../Constants/Api.dart';
import '../../Constants/Colors.dart';
import '../../Presentation/common_button.dart';
import '../../Presentation/textfeild_validation.dart';
import '../Login/view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cpasswordController = TextEditingController();

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
                      height: ScreenUtil().setHeight(150),
                      padding: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
                      alignment: Alignment.center,
                      child: Image(
                        image: AssetImage("assets/images/plogo.png"),
                        fit: BoxFit.cover,
                        height: ScreenUtil().setHeight(120),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(18),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Register',
                        style: TextStyle(
                          color: secondaryColor,
                          fontSize: ScreenUtil().setWidth(16),
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    Container(
                      height: ScreenUtil().setHeight(105),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Name',
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
                              controller: _nameController,
                              title: "Name",
                              isPassword: false,
                              obs: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field is required';
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
                                'Mobile',
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
                              controller: _mobileController,
                              title: "Mobile Number",
                              isPassword: false,
                              obs: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field is required';
                                } else if (!RegExp(
                                        r'(^(?:[+0]9)?[0-9]{10,12}$)')
                                    .hasMatch(_mobileController.text)) {
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
                                'Password',
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: ScreenUtil().setWidth(12),
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(6),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    _showDialoge();
                                  },
                                  child: Image.asset(
                                    "assets/icons/info.png",
                                    height: ScreenUtil().setWidth(12),
                                    width: ScreenUtil().setWidth(12),
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(5),
                          ),
                          Container(
                            height: ScreenUtil().setHeight(75),
                            child: TextFieldWidgetValidation(
                              controller: _passwordController,
                              isPassword: true,
                              obs: true,
                              title: "Password",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password is required';
                                } else if (value.length < 8 ||
                                    value.length > 20) {
                                  return 'Password must be between 8 and 20 characters';
                                } else if (!RegExp(r'(?=.*[a-z])')
                                    .hasMatch(value)) {
                                  return 'Password must contain at least 1 lowercase letter';
                                } else if (!RegExp(r'(?=.*[A-Z])')
                                    .hasMatch(value)) {
                                  return 'Password must contain at least 1 uppercase letter';
                                } else if (!RegExp(r'(?=.*\d)')
                                    .hasMatch(value)) {
                                  return 'Password must contain at least 1 number';
                                } else if (!RegExp(r'(?=.*[@&])')
                                    .hasMatch(value)) {
                                  return 'Password must contain at least 1 special character (@ or &)';
                                } return null; // Return null if the input is valid
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
                                'Confirm Password',
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
                              controller: _cpasswordController,
                              title: "Confirm Password",
                              isPassword: false,
                              obs: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                } else if (value != _passwordController.text) {
                                  return 'Passwords do not match';
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
                        : GestureDetector(
                            onTap: () {
                              setState(() {
                                if (_formKey.currentState!.validate()) {
                                  // Check additional conditions, such as non-empty text fields
                                  if (
                                      _mobileController.text.isNotEmpty &&
                                      _nameController.text.isNotEmpty &&
                                      _passwordController.text.isNotEmpty &&
                                          _cpasswordController.text.isNotEmpty
                                  ) {
                                    // Validation passed, initiate the login
                                    setState(() {
                                      isloading = true;
                                    });
                                    SignUp();
                                  } else {
                                    // Show an error message for empty text fields
                                  }
                                } else {
                                  // Validation failed, show an error message
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Please fill in the required field.'),
                                    ),
                                  );
                                }
                              });
                              /*Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return RegisterOtpPage();
                            },
                          ),
                        );*/
                            },
                            child: RoundedButton(
                              text: 'Sign Up',
                              press: () {
                                /*Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return RegisterOtpPage();
                            },
                          ),
                        );*/
                              },
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
                              return LoginPage();
                            },
                          ),
                        );
                      },
                      child: Container(
                        height: ScreenUtil().setHeight(40),
                        child: Center(
                          child: Text(
                            'Already Registered? Log in now',
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
                    Container(
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showDialoge() {
    Size size = MediaQuery.of(context).size;

    Widget okButton = TextButton(
      child: Text("OK",
          style: TextStyle(
              fontFamily: 'poppins',
              fontWeight: FontWeight.bold,
              fontSize: size.width * 0.05,
              color: primaryColor)),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      insetPadding: EdgeInsets.all(ScreenUtil().setWidth(30)),
      content: Container(
        height: ScreenUtil().setHeight(210),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: iconColor,
                      size: ScreenUtil().setHeight(18),
                    )
                ),
              ],
            ),
            SizedBox(
              height: ScreenUtil().setHeight(16),
            ),
            Container(
              width: ScreenUtil().setWidth(350),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Your password should contain:",
                          style: TextStyle(
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w600,
                              fontSize: ScreenUtil().setWidth(14),
                              color: primaryColor)),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(16),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/icons/arrow.png",
                        width: ScreenUtil().setHeight(13),
                        height: ScreenUtil().setHeight(13),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(11),
                      ),
                      Text("Between 8 to 20 characters",
                          style: TextStyle(
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w300,
                              fontSize: ScreenUtil().setWidth(12),
                              color: primaryColor)),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(8),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/icons/arrow.png",
                        width: ScreenUtil().setHeight(13),
                        height: ScreenUtil().setHeight(13),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(11),
                      ),
                      Text("At least 1 lowercase",
                          style: TextStyle(
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w300,
                              fontSize: ScreenUtil().setWidth(12),
                              color: primaryColor)),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(8),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/icons/arrow.png",
                        width: ScreenUtil().setHeight(13),
                        height: ScreenUtil().setHeight(13),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(11),
                      ),
                      Text("At least 1 uppercase",
                          style: TextStyle(
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w300,
                              fontSize: ScreenUtil().setWidth(12),
                              color: primaryColor)),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(8),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/icons/arrow.png",
                        width: ScreenUtil().setHeight(13),
                        height: ScreenUtil().setHeight(13),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(11),
                      ),
                      Text("At least 1 number",
                          style: TextStyle(
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w300,
                              fontSize: ScreenUtil().setWidth(12),
                              color: primaryColor)),
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(8),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/icons/arrow.png",
                        width: ScreenUtil().setHeight(13),
                        height: ScreenUtil().setHeight(13),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(11),
                      ),
                      Text("At least 1 special characters(Eg.@ &)",
                          style: TextStyle(
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w300,
                              fontSize: ScreenUtil().setWidth(12),
                              color: primaryColor)),
                    ],
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
      /*  actions: [
        okButton,
      ],*/
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> SignUp() async {
    setState(() {
      isloading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final uri = Uri.parse('https://pokerprosuite.com/api/sign-up');
  //  var url = Uri.http(uri, '/api/createUser');
    //- ---------------------------------------------------------
    var request = new http.MultipartRequest("POST", uri);
    request.fields['name'] = _nameController.text;
    request.fields['password'] = _passwordController.text;
    request.fields['mobile'] = _mobileController.text;
    request.fields['password_confirmation'] = _cpasswordController.text;

    request.send().then((response) {
      if (response.statusCode == 200) {
        print("Uploaded!");
        int statusCode = response.statusCode;
        print("response::$response");
        response.stream.transform(utf8.decoder).listen((value) {
          print("ResponseSellerVerification" + value);
          setState(() {
            isloading = false;
          });
          var getdata = json.decode(value);

          FocusScope.of(context).requestFocus(FocusNode());
          if (getdata["status"] && getdata['isregister']) {
            Message(context, "Registration Successfully");

            Future.delayed(const Duration(milliseconds: 1000), () {
              setState(() {
                // todo
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginPage();
                    },
                  ),
                );
              });
            });
            /* prefs.setString(
                "access_token", "Bearer ${getdata["token"].toString()}");
            prefs.setString("name", getdata["user"][0]["name"].toString());
            prefs.setString("UserId", "${getdata["user"][0]["id"].toString()}");
            prefs.setString("email", getdata["user"][0]["email"].toString());
            prefs.setString("phone", getdata["user"][0]["mobile"].toString());
            prefs.setString(
                "referel_code", getdata["user"][0]["referel_code"].toString());
            prefs.setString("bonus", getdata["user"][0]["bouns"].toString());
            prefs.setBool("isLogging", true);*/
          } else {
            Message(context, getdata["message"]);
          }
        });
      } else {
        setState(() {
          isloading = false;
        });
        Message(context, "Something went Wrong");
      }
    });
  }
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> Message(
    BuildContext context, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 800),
    ),
  );
}
