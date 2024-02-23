import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:poker_income/Presentation/common_button.dart';
import 'package:poker_income/Screens/CompletedSessionPage.dart';
import '../Constants/Colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Constants/Api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'BottomNavigationBar.dart';
import 'Registration/view.dart';

class AddSessionDetailsPage extends StatefulWidget {
  const AddSessionDetailsPage({Key? key}) : super(key: key);

  @override
  State<AddSessionDetailsPage> createState() => _AddSessionDetailsPageState();
}

class _AddSessionDetailsPageState extends State<AddSessionDetailsPage> {

  TextEditingController buyInController = TextEditingController();
  TextEditingController tipsController = TextEditingController();
  TextEditingController NoteController = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  TextEditingController cashedOutController = TextEditingController();
  bool isloading = false;

  TimeOfDay timeOfDay = TimeOfDay.now();


  @override
  void initState() {
    dateInput.text = "";
    super.initState();
  }

  FocusNode _focusNode = FocusNode();

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
          "Add Session Details",
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
                controller: buyInController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      left: 20.0, top: 20.0, bottom: 20.0, right: 20.0),
                  isDense: false,
                  filled: true,
                  fillColor: secondaryColor,
                  labelText: 'Buy In',
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
                controller: tipsController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      left: 20.0, top: 20.0, bottom: 20.0, right: 20.0),
                  isDense: false,
                  filled: true,
                  fillColor: secondaryColor,
                  labelText: 'Tips/Meals',
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

              GestureDetector(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2100));

                  if (pickedDate != null) {
                    print(
                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
                    print(
                        formattedDate); //formatted date output using intl package =>  2021-03-16
                    setState(() {
                      dateInput.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {}
                },
                child: TextFormField(
                  readOnly: true,
                  enabled:false,
                  keyboardType: TextInputType.datetime,
                  textAlignVertical: TextAlignVertical.center,
                  controller: dateInput,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        left: 20.0, top: 20.0, bottom: 20.0, right: 20.0),
                    isDense: true,
                    filled: true,
                    fillColor: secondaryColor,
                    labelText: 'Enter Date',
                    labelStyle: TextStyle(
                        fontFamily: 'railway',
                        fontSize: ScreenUtil().setHeight(12),
                        fontWeight: FontWeight.normal,
                        color: primaryTextColor),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: primaryTextColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: primaryTextColor,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: primaryTextColor, width: 1.0),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: ScreenUtil().setHeight(20),
              ),

              GestureDetector(
                onTap: () async {
                  displayTimePicker(context);
                },
                child: TextFormField(
                  readOnly: true,
                  enabled:false,
                  keyboardType: TextInputType.datetime,
                  textAlignVertical: TextAlignVertical.center,
                  controller: timeinput,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        left: 20.0, top: 20.0, bottom: 20.0, right: 20.0),
                    isDense: true,
                    filled: true,
                    fillColor: secondaryColor,
                    labelText: 'Enter Time',
                    labelStyle: TextStyle(
                        fontFamily: 'railway',
                        fontSize: ScreenUtil().setHeight(12),
                        fontWeight: FontWeight.normal,
                        color: primaryTextColor),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: primaryTextColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: primaryTextColor,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: primaryTextColor, width: 1.0),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
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
                controller: cashedOutController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                      left: 20.0, top: 20.0, bottom: 20.0, right: 20.0),
                  isDense: false,
                  filled: true,
                  fillColor: secondaryColor,
                  labelText: 'Cashed Out',
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
                  addSessionApi();
                },
                  child: RoundedButton(text: "Submit", press: () {}))

            ],
          ),
        ),
      ),
    );
  }

  Future displayTimePicker(BuildContext context) async {
    var time = await showTimePicker(
        context: context,
        initialTime: timeOfDay);

    if (time != null) {
      setState(() {
        timeinput.text = "${time.hour}:${time.minute}";
      });
    }
  }


  Future<void> addSessionApi() async {
    setState(() {
      isloading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final uri = Uri.parse('https://pokerprosuite.com/api/addsession');
    //  var url = Uri.http(uri, '/api/createUser');
    //- ---------------------------------------------------------
    var request = new http.MultipartRequest("POST", uri);
    request.headers['Authorization'] = 'Bearer ${prefs.getString('token')}';
    request.fields['cash_in'] = buyInController.text;
    request.fields['time'] = timeinput.text;
    request.fields['date'] = dateInput.text;
    request.fields['cash_out'] = cashedOutController.text;

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
            Message(context, "Session Added successfully.");

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
