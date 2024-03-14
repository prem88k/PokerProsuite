import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../Constants/Api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../Constants/Colors.dart';
import '../Presentation/PagerState.dart';
import 'HomePage.dart';
import 'HostPage.dart';
import 'RoomChatPage.dart';
import 'MyGamesPage.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  @override
  _BottomNavigationBarScreenState createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {


  int currentIndex = 0;


  /// Set a type current number a layout class
  Widget callPage(int current) {
    switch (current) {
      case 0:
        return new HomePage();
      case 1:
        return new HostPage();
      case 2:
        return new MyGamesPage();
      case 3:
        return new RoomChatPage();
      default:
        return HomePage();
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  /// Build BottomNavigationBar Widget
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
    return Scaffold(
      key: _scaffoldKey,
      body: callPage(currentIndex),
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: secondaryColor,
        currentIndex: currentIndex,
        onTap: (i) => setState(() => currentIndex = i),
        itemShape: StadiumBorder(side: BorderSide.none),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(Icons.home,color: currentIndex == 0?appColor:borderColor,),
            title: Text("Home",style:  TextStyle(
                fontFamily: 'work',
                fontSize: ScreenUtil().setHeight(13),
                fontWeight: FontWeight.bold,
                color:  currentIndex == 0?darkTextColor:borderColor),),
            selectedColor: primaryColor,

          ),

          /// Likes
          SalomonBottomBarItem(
            icon: Icon(Icons.add_circle,color: currentIndex == 1?appColor:borderColor,),
            title: Text("Host",style:  TextStyle(
                fontFamily: 'work',
                fontSize: ScreenUtil().setHeight(13),
                fontWeight: FontWeight.bold,
                color:  currentIndex == 1?darkTextColor:borderColor)),
            selectedColor:primaryColor,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.games,color: currentIndex == 2?appColor:borderColor,),
            title: Text("My Games",style:  TextStyle(
                fontFamily: 'work',
                fontSize: ScreenUtil().setHeight(13),
                fontWeight: FontWeight.bold,
                color:  currentIndex == 2?darkTextColor:borderColor)),
            selectedColor:primaryColor,
          ),
          /// Profile
          SalomonBottomBarItem(
            icon: Icon(Icons.chat,color: currentIndex == 3?appColor:borderColor,),
            title: Text("Chat",style:  TextStyle(
                fontFamily: 'work',
                fontSize: ScreenUtil().setHeight(13),
                fontWeight: FontWeight.bold,
                color:  currentIndex == 3?darkTextColor:borderColor)),
            selectedColor:primaryColor,
          ),
        ],
      ),
    );

  }

}
