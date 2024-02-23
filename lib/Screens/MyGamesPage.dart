import 'package:flutter/material.dart';
import 'package:poker_income/Model/GetMyGamesData.dart';
import 'package:http/http.dart';
import 'dart:convert';
import '../Constants/Api.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Constants/Colors.dart';

class MyGamesPage extends StatefulWidget {
  const MyGamesPage({Key? key}) : super(key: key);

  @override
  State<MyGamesPage> createState() => _MyGamesPageState();
}

class _MyGamesPageState extends State<MyGamesPage> {
  bool isloading = false;
  SharedPreferences ?prefs;
  late GetMyGamesData getMyGamesData;
  List<GamesList>? gamesList = [];

  @override
  void initState() {
    super.initState();
    getGamesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0,
        backgroundColor: secondaryColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "My Games",
          style: TextStyle(
            color: appColor,
            fontSize: ScreenUtil().setWidth(18),
            fontFamily: 'poppins',
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body:  isloading
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
              SizedBox(
                height: ScreenUtil().setHeight(15),
              ),

              gamesList!.length == 0 ?
              Center(
                child: Text(
                  "My Games Not Found",
                  style: TextStyle(
                    color: appColor,
                    fontSize: ScreenUtil().setHeight(12),
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ): ListView.builder(
                itemCount: gamesList!.length,
                primary: false,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  return _buildServiceList(i);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceList(int i) {
    return Container(
      margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(10.0),
            left: ScreenUtil().setWidth(8),
            right: ScreenUtil().setWidth(8)),
        child: Container(
          width: ScreenUtil().screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: ScreenUtil().setWidth(5),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: ScreenUtil().setWidth(235),
                              alignment: Alignment.topLeft,
                              child: Text(
                                  gamesList![i].address != null ?
                                  gamesList![i].address.toString() : "ABC",
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setWidth(15),
                                      color: appColor,
                                      fontFamily: 'poppins',
                                      fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(5),
                        ),
                        Container(
                          width: ScreenUtil().setWidth(235),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: ScreenUtil().setWidth(235),
                                alignment: Alignment.topLeft,
                                child: Text(
                                    gamesList![i].time != null ?
                                    "Time :-  ${gamesList![i].time.toString()}" : "ABC",
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setWidth(12),
                                        color: appColor,
                                        fontFamily: 'poppins',
                                        fontWeight: FontWeight.w600)),
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getGamesList() async {
    prefs = await SharedPreferences.getInstance();
    //print((int.parse(bidValueController.text)*100)/int.parse(contestPrice));
    setState(() {
      isloading = true;
    });
    var uri = Uri.https(
      apiBaseUrl,
      '/api/mygames',
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
    print("My Games Response::$responseBody");
    if (statusCode == 200) {
      if (getdata["success"]) {
        getMyGamesData = GetMyGamesData.fromJson(jsonDecode(responseBody));
        gamesList!.addAll(getMyGamesData.rides!);
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
