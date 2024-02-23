import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poker_income/Screens/Registration/view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../Constants/Colors.dart';
import '../../Presentation/PagerState.dart';
import '../Login/view.dart';


class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  State<IntroductionScreen> createState() => _SplashScreenTwoState();
}

class _SplashScreenTwoState extends State<IntroductionScreen> {
  List<String> bannerList = [];
  late PageController controller1;
  final StreamController<PagerState> pagerStreamController =
      StreamController<PagerState>.broadcast();

  @override
  void initState() {
    // TODO: implement initState
    controller1 = PageController(initialPage: 0, viewportFraction: 1.0);
    bannerList.add("assets/images/intro.jpg");
    bannerList.add("assets/images/intro.jpg");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
    ));
    Size size = MediaQuery.of(context).size;
    ScreenUtil.init(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: secondaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                    height: size.height * 0.45,
                    width: size.width,
                    child: PageView.builder(
                      itemCount: bannerList.length,
                      pageSnapping: false,
                      controller: controller1,
                      onPageChanged: (int value) {
                        controller1.addListener(() {
                          pagerStreamController
                              .add(PagerState(controller1.page!.toInt()));
                        });
                      },
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          //  padding: EdgeInsets.only(right: 10.0),
                          child: Column(
                            children: [
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 0),
                                  child: Container(
                                    width: size.width,
                                    height: size.height * 0.45,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(bannerList[index]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ); // you forgot this
                      },
                    )),
             /*   Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
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
                      margin: EdgeInsets.only(top:ScreenUtil().setHeight(30),right:ScreenUtil().setHeight(15) ),
                      height: ScreenUtil().setHeight(30),
                      width: ScreenUtil().setWidth(70),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: inactiveColor),
                      child: Center(
                        child: Text(
                          "Skip",
                          style: TextStyle(
                            color: appColor,
                            fontSize: ScreenUtil().setHeight(10),
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),*/
              ],
            ),
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            Container(
              child: SmoothPageIndicator(
                controller: controller1,
                count: bannerList.length,
                effect: ScaleEffect(
                    scale: 1.5,
                    dotHeight: ScreenUtil().setHeight(7),
                    dotWidth: ScreenUtil().setHeight(7),
                    dotColor: inactiveColor,
                    activeDotColor: appColor,
                    activePaintStyle: PaintingStyle.fill,
                    strokeWidth: 2),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Welcome to ",
                    style: TextStyle(
                      color: primaryTextColor,
                      fontSize: ScreenUtil().setWidth(16),
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "POKER",
                    style: TextStyle(
                      color: appColor,
                      fontSize: ScreenUtil().setWidth(16),
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: ScreenUtil().setHeight(12),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    width: ScreenUtil().setWidth(300),
                    child: Column(
                      children: [
                        Text(
                          "Enjoy the game",
                          style: TextStyle(
                            color: primaryTextColor,
                            fontSize: ScreenUtil().setWidth(30),
                            fontFamily: 'poppins',
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        /*Text(
                          "and game",
                          style: TextStyle(
                            color: primaryTextColor,
                            fontSize: ScreenUtil().setWidth(30),
                            fontFamily: 'poppins',
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),*/
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: ScreenUtil().setHeight(25),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap:(){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return RegistrationPage();
                          },
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          height: ScreenUtil().setHeight(50),
                          width: ScreenUtil().setHeight(50),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: appColor),
                          child: Padding(
                            padding: EdgeInsets.all(ScreenUtil().setHeight(15)),
                            child: Image.asset(
                              "assets/icons/login_icon.png",
                              height: ScreenUtil().setHeight(20),
                              width: ScreenUtil().setHeight(20),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(8),
                        ),
                        Text(
                          "Register\n ",
                          style: TextStyle(
                            color: primaryTextColor,
                            fontSize: ScreenUtil().setHeight(10),
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.055,
                  ),
                  GestureDetector(
                    onTap:(){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginPage();
                          },
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          height: ScreenUtil().setHeight(50),
                          width: ScreenUtil().setHeight(50),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: appColor),
                          child: Padding(
                            padding: EdgeInsets.all(ScreenUtil().setHeight(15)),
                            child: Image.asset(
                              "assets/icons/register_icon.png",
                              height: ScreenUtil().setHeight(20),
                              width: ScreenUtil().setHeight(20),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(8),
                        ),
                        Text(
                          "Login\n ",
                          style: TextStyle(
                            color: primaryTextColor,
                            fontSize: ScreenUtil().setHeight(10),
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.055,
                  ),
                 /* Column(
                    children: [
                      Container(
                        height: ScreenUtil().setHeight(50),
                        width: ScreenUtil().setHeight(50),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: appColor),
                        child: Padding(
                          padding: EdgeInsets.all(ScreenUtil().setHeight(15)),
                          child: Image.asset(
                            "assets/icons/lobb5_white.png",
                            height: ScreenUtil().setHeight(20),
                            width: ScreenUtil().setHeight(20),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(8),
                      ),
                      Text(
                        "Continue\nas guest",
                        style: TextStyle(
                          color: primaryTextColor,
                          fontSize: ScreenUtil().setHeight(10),
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  )*/
                ],
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(14),
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
                height: ScreenUtil().setHeight(37),
                width: ScreenUtil().setWidth(120),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: appColor),
                child: Center(
                  child: Text(
                    "Next",
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: ScreenUtil().setHeight(12),
                      fontFamily: 'poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
