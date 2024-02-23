import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poker_income/Model/GetProfileData.dart';
import 'package:poker_income/Presentation/common_button.dart';
import 'package:poker_income/Screens/EditProfile.dart';
import '../Constants/Colors.dart';
import 'ChangePasswordPage.dart';
import 'package:http/http.dart';
import 'dart:convert';
import '../Constants/Api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  bool isloading = false;
  SharedPreferences ?prefs;
  late GetProfileData getProfileData;
  List<ProfileList>? profileList = [];

  @override
  void initState() {
    getProfileData = GetProfileData();
    super.initState();
    getProfileList();
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
          "Profile",
          style: TextStyle(
            color: appColor,
            fontSize: ScreenUtil().setWidth(18),
            fontFamily: 'poppins',
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: isloading
          ? Center(
        child: CircularProgressIndicator(
          color: appColor,
        ),
      )
          : SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(10.0),
            right: ScreenUtil().setWidth(10.0),
            top: ScreenUtil().setHeight(10.0),
            bottom: ScreenUtil().setHeight(10.0),
          ),
          child: Column(
            children: [

              Padding(
                padding:EdgeInsets.only(bottom: ScreenUtil().setHeight(10), top: ScreenUtil().setHeight(20)),
                child: GestureDetector(
                  onTap: () {
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return CompletedSessionPage();
                        },
                      ),
                    );*/
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                "Name",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: ScreenUtil().setWidth(14),
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    getProfileData.data?[0].name != null ?
                                    getProfileData.data![0].name.toString() : "",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: ScreenUtil().setWidth(14),
                                      fontFamily: 'poppins',
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: ScreenUtil().setHeight(5),),
                        Divider(
                          thickness: 0.5,
                          color: lightTextColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding:EdgeInsets.only(bottom: ScreenUtil().setHeight(10), top: ScreenUtil().setHeight(20)),
                child: GestureDetector(
                  onTap: () {
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return CompletedSessionPage();
                        },
                      ),
                    );*/
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                'Mobile',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: ScreenUtil().setWidth(14),
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                            getProfileData.data?[0].mobile != null ?
                            getProfileData.data![0].mobile.toString() : "",
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: ScreenUtil().setWidth(14),
                                      fontFamily: 'poppins',
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: ScreenUtil().setHeight(5),),
                        Divider(
                          thickness: 0.5,
                          color: lightTextColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ChangePasswordPage(getProfileData.data![0].mobile);
                      },
                    ),
                  );
                },
                  child: RoundedButton(text: "Change Password",  press: () {},)),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return EditProfile(getProfileData);
                      },
                    ),
                  );
                },
                  child: RoundedButton(text: "Edit Profile",  press: () {},))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getProfileList() async {
    prefs = await SharedPreferences.getInstance();
    //print((int.parse(bidValueController.text)*100)/int.parse(contestPrice));
    setState(() {
      isloading = true;
    });
    var uri = Uri.https(
      apiBaseUrl,
      '/api/profile',
    );

    print('${prefs!.getString('token')}');

    final encoding = Encoding.getByName('utf-8');

    final headers = {'Authorization': 'Bearer ${prefs!.getString('token')}'};

    Response response = await get(
      uri,
      headers: headers,
    );

    var getdata = json.decode(response.body);
    String responseBody = response.body;
    int statusCode = response.statusCode;
    print(getdata["success"]);
    print("My Profile Response::$responseBody");
    if (statusCode == 200) {
      if (getdata["success"]) {
        getProfileData = GetProfileData.fromJson(jsonDecode(responseBody));
        profileList!.addAll(getProfileData.data!);
        setState(() {
          isloading = false;
        });
      } else {
        setState(() {
          isloading = false;
        });
      }
    } else {
      setState(() {
        isloading = false;
      });
    }
  }
}
