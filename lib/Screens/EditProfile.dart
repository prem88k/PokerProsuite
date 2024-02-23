import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poker_income/Model/GetProfileData.dart';
import 'package:poker_income/Presentation/common_button.dart';
import 'package:poker_income/Screens/BottomNavigationBar.dart';
import '../Constants/Colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Constants/Api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Registration/view.dart';

class EditProfile extends StatefulWidget {
  GetProfileData getProfileData;
  EditProfile(this.getProfileData);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  bool isloading = false;

  @override
  void initState() {
    nameController.text = widget.getProfileData.data![0].name.toString();
    mobileController.text = widget.getProfileData.data![0].mobile.toString();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0,
        backgroundColor: secondaryColor,
        iconTheme: IconThemeData(color: appColor),
        elevation: 1,
        centerTitle: true,
        title: Text(
          "Edit Profile",
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
                controller: nameController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      left: 20.0, top: 20.0, bottom: 20.0, right: 20.0),
                  isDense: false,
                  filled: true,
                  fillColor: secondaryColor,
                  labelText: 'Name',
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
                controller: mobileController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      left: 20.0, top: 20.0, bottom: 20.0, right: 20.0),
                  isDense: false,
                  filled: true,
                  fillColor: secondaryColor,
                  labelText: 'Mobile',
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
                  editProfileApi();
                },
                  child: RoundedButton(text: "Edit Profile", press: () {}))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> editProfileApi() async {
    setState(() {
      isloading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final uri = Uri.parse('https://pokerprosuite.com/api/editprofile');
    //  var url = Uri.http(uri, '/api/createUser');
    //- ---------------------------------------------------------
    var request = new http.MultipartRequest("POST", uri);
    request.headers['Authorization'] = 'Bearer ${prefs.getString('token')}';
    request.fields['name'] = nameController.text;
    request.fields['mobile'] = mobileController.text;

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
            Message(context, "Profile Edit Successfully.");

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
