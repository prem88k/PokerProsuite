import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Constants/Colors.dart';
import '../Presentation/common_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Constants/Api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'BottomNavigationBar.dart';
import 'Registration/view.dart';

class ChangePasswordPage extends StatefulWidget {
  String? mobile;
  ChangePasswordPage(this.mobile);


  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {

  TextEditingController mobileController = TextEditingController();
  TextEditingController oldController = TextEditingController();
  TextEditingController newController = TextEditingController();
  bool isloading = false;

  @override
  void initState() {
    mobileController.text = widget.mobile!;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        bottomOpacity: 0,
        backgroundColor: secondaryColor,
        iconTheme: IconThemeData(color: appColor),
        elevation: 1,
        centerTitle: true,
        title: Text(
          "Change Password",
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

              TextFormField(
                maxLines: 1,
                keyboardType: TextInputType.text,
                textAlignVertical: TextAlignVertical.center,
                controller: mobileController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      left: 20.0, top: 20.0, bottom: 20.0, right: 20.0),
                  isDense: false,
                  filled: true,
                  fillColor: secondaryColor,
                  labelText: 'Mobile Number',
                  labelStyle: TextStyle(
                      fontFamily: 'railway',
                      fontSize: ScreenUtil().setHeight(12),
                      fontWeight: FontWeight.normal,
                      color: primaryTextColor),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: lightTextColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: lightTextColor,
                      width: 0.2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: lightTextColor, width: 0.2),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),

              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),

              TextFormField(
                maxLines: 1,
                keyboardType: TextInputType.text,
                textAlignVertical: TextAlignVertical.center,
                controller: oldController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      left: 20.0, top: 20.0, bottom: 20.0, right: 20.0),
                  isDense: false,
                  filled: true,
                  fillColor: secondaryColor,
                  labelText: 'Old Password',
                  labelStyle: TextStyle(
                      fontFamily: 'railway',
                      fontSize: ScreenUtil().setHeight(12),
                      fontWeight: FontWeight.normal,
                      color: primaryTextColor),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: lightTextColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: lightTextColor,
                      width: 0.2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: lightTextColor, width: 0.2),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),

              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),

              TextFormField(
                maxLines: 1,
                keyboardType: TextInputType.text,
                textAlignVertical: TextAlignVertical.center,
                controller: newController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      left: 20.0, top: 20.0, bottom: 20.0, right: 20.0),
                  isDense: false,
                  filled: true,
                  fillColor: secondaryColor,
                  labelText: 'New Password',
                  labelStyle: TextStyle(
                      fontFamily: 'railway',
                      fontSize: ScreenUtil().setHeight(12),
                      fontWeight: FontWeight.normal,
                      color: primaryTextColor),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: lightTextColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: lightTextColor,
                      width: 0.2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: lightTextColor, width: 0.2),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),


              SizedBox(
                height: ScreenUtil().setHeight(35),
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
                  changePaaswordApi();
                },
                  child: RoundedButton(text: "Change Password", press: () {}))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> changePaaswordApi() async {
    setState(() {
      isloading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final uri = Uri.parse('https://pokerprosuite.com/api/reset-password');
    var request = new http.MultipartRequest("POST", uri);
    request.headers['Authorization'] = 'Bearer ${prefs.getString('token')}';
    request.fields['mobile'] = mobileController.text;
    request.fields['old_password'] = oldController.text;
    request.fields['new_password'] = newController.text;

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
          if (getdata["success"]) {
            Message(context, "Password Changed Successfully.");

            Future.delayed(const Duration(milliseconds: 1000), () {
              setState(() {
                // todo
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return BottomNavigationBarScreen();
                    },
                  ),
                );
              });
            });
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
