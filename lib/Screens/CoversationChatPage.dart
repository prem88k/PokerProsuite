import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Constants/Api.dart';
import '../Constants/Colors.dart';
import '../Model/GetMessageData.dart';
import 'Registration/view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';

class CoversationChatPage extends StatefulWidget {
      int? roomId;
      int? gameId;
      String groupName;
  CoversationChatPage(this.roomId, this.gameId, this.groupName);

  @override
  State<CoversationChatPage> createState() => _CoversationChatPageState();
}

class _CoversationChatPageState extends State<CoversationChatPage> {

  bool isloading = false;
  bool messageLoading = false;
  final TextEditingController _messageController = TextEditingController();
  late GetMessageData getMessageData;
  List<MessageList>? messageList = [];

  String code = '';
  late Timer _timer;
  @override
  void initState() {
    // TODO: implement initState
    _loadCounter();
    super.initState();
    startTimer();
  }

  void startTimer() {
    const Duration period = Duration(seconds: 3); // Change the duration as needed

    _timer = Timer.periodic(period, (Timer timer) {
      FetchMessage(true);// Call your API function
    });
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      code = (prefs.getString('userId')) ?? "";
      print(code);
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer to avoid calling setState() after disposal
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: secondaryColor,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: primaryColor,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                /*  CircleAvatar(
                    backgroundImage: NetworkImage("<https://randomuser.me/api/portraits/men/5.jpg>"),
                    maxRadius: 20,
                  ),*/
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(widget.groupName,
                          style: TextStyle(
                              color: appColor,
                              fontFamily: 'railway',
                              fontSize: size.height * 0.025,
                              fontWeight: FontWeight.normal)),
                    /*  SizedBox(
                        height: 1,
                      ),
                      Text("ABC",
                          style: TextStyle(
                              fontFamily: 'railway',
                              color: primaryColor,
                              fontSize: size.height * 0.015,
                              fontWeight: FontWeight.normal)),*/
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body:  messageLoading ?Center(child: CircularProgressIndicator(backgroundColor: appColor,)):Stack(
        children: <Widget>[
          messageLoading ?Center(child: CircularProgressIndicator(backgroundColor: appColor,)): messageList!.length != 0
              ? ListView.builder(
            itemCount: messageList!.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            itemBuilder: (context, index) {
              return messageList![index].senderId.toString() == code ?
                Container(
               // color: secondaryColor,
                alignment: Alignment.topRight,
                padding: EdgeInsets.only(
                    left: 16, right: 16, top: 10, bottom: 10),
                child: Column(
                  children: [
                    Text(
                      messageList![index].message!,
                      style: TextStyle(
                          fontFamily: 'railway',
                          color: primaryColor,
                          fontSize: size.height * 0.025,
                          fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: size.height * 0.005,
                    ),
                    Text(
                      DateFormat("yyyy-MM-dd hh:mm:ss").format(
                          DateTime.parse(messageList![index].createdAt!)),
                      style: TextStyle(
                          fontFamily: 'railway',
                          color: primaryTextColor,
                          fontSize: size.height * 0.012,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ) :
                Container(
               // color: secondaryColor,
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(
                    left: 16, right: 16, top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      messageList![index].message!,
                      style: TextStyle(
                          fontFamily: 'railway',
                          color: primaryColor,
                          fontSize: size.height * 0.025,
                          fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      height: size.height * 0.005,
                    ),
                    Text(
                      DateFormat("yyyy-MM-dd hh:mm:ss").format(
                          DateTime.parse(messageList![index].createdAt!)),
                      style: TextStyle(
                          fontFamily: 'railway',
                          color: primaryTextColor,
                          fontSize: size.height * 0.012,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              );
            },
          )
              : Center(
            child: Text(
              "No Message Found",
              style: TextStyle(
                  fontFamily: 'railway',
                  color: primaryTextColor,
                  fontSize: size.height * 0.025,
                  fontWeight: FontWeight.normal),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: secondaryColor,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        border: Border.all(color: primaryColor),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.add,
                        color: appColor,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      style: TextStyle(
                        color: primaryColor,
                      ),
                      decoration: InputDecoration(
                          hintText: "Write Message",
                          hintStyle: TextStyle(color: primaryTextColor,),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      CallChatAPI();

                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: appColor,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> CallChatAPI() async {
    setState(() {
      isloading = true;
    });

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var uri = Uri.https(
      apiBaseUrl,
      '/api/sendmessage',
    );

    final headers = {'Authorization': 'Bearer ${prefs!.getString('token')}'};

    Map<String, dynamic> body = {
      'game_id': widget.gameId.toString(),
      'room_id': widget.roomId.toString(),
      'message': _messageController.text,
    };

    String jsonBody = json.encode(body);
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
    print("Message::$responseBody");
    if (statusCode == 200) {
      if (getdata["success"]) {
      /*  setState(() {
          isloading = false;
        });*/
        _messageController.clear();
        Message(context, "Message sent Successfully");
        FetchMessage(false);
        /*bookTable();*/

      } else {
        setState(() {
          isloading = false;
        });
        Message(context, getdata["message"]);
      }
    } else {
      setState(() {
        isloading = false;
      });
      Message(context, getdata["error"]);
    }
  }

  Future<void> FetchMessage(bool loading) async {
    messageList!.clear();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
   /* setState(() {
      messageLoading = true;
    });*/

    print(widget.gameId.toString());

    var uri = Uri.https(
      apiBaseUrl,
      '/api/getmessage',
    );

    final headers = {'Authorization': 'Bearer ${prefs!.getString('token')}'};

    Map<String, dynamic> body = {
      'game_id': widget.gameId.toString(),
    };

    String jsonBody = json.encode(body);
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
    print("Message::$responseBody");
    if (statusCode == 200) {
      if (mounted)
      if (getdata["success"]) {
        setState(() {
          messageLoading = false;
        });
        getMessageData = GetMessageData.fromJson(jsonDecode(responseBody));
        messageList!.addAll(getMessageData.data!);
      } else {
        setState(() {
          messageLoading = false;
        });
      }
    } else {
      setState(() {
        isloading = false;
      });
      Message(context, getdata["error"]);
    }
  }
}
