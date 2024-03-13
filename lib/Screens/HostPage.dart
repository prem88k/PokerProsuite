import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:poker_income/Model/GetAllPlayerData.dart';
import '../Constants/Api.dart';
import '../Constants/Colors.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import '../Presentation/common_button.dart';
import 'BottomNavigationBar.dart';
import 'Registration/view.dart';

class HostPage extends StatefulWidget {
  const HostPage({Key? key}) : super(key: key);

  @override
  State<HostPage> createState() => _HostPageState();
}

class _HostPageState extends State<HostPage> {

  TextEditingController dateInput = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController selectedArea = TextEditingController();
  SharedPreferences ?prefs;


  TimeOfDay timeOfDay = TimeOfDay.now();
  bool isloading = false;

  late String placeid;
  String googleApikey = "AIzaSyCkW__vI2DazIWYjIMigyxwDtc_kyCBVIo";
  GoogleMapController? mapController; //contrller for Google map
  LatLng? showLocation;
  String location = "Select Leaving from Location..";
  double? pickUpLat;
  double? pickUpLong;

  late GetAllPlayerData getAllPlayerData;
  List<PlayerList>? playerList = [];
  List<ValueItem> multiSelectOptions = [];
  List<int> selectedPlayerIds = [];
  String selectedGate = "";


  @override
  void initState() {
    selectedArea.addListener(() {
      /*_onChanged();*/
    });
    dateInput.text = "";
    super.initState();
    getPlayersList();
    getAllPlayerData = GetAllPlayerData();
  }

  void onOptionSelected(List<ValueItem> selectedOptions) {
    setState(() {
      selectedPlayerIds = selectedOptions.map((item) => int.parse(item.value!)).toList();
      print('Selected Player IDs: $selectedPlayerIds');
    });
  }

  FocusNode _focusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0,
        backgroundColor: secondaryColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Host Game",
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
          child: Column(
            children: [

              SizedBox(
                height: ScreenUtil().setHeight(15),
              ),

              Padding(
                padding: EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
                child: TextFormField(
                  focusNode: _focusNode,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  textAlignVertical: TextAlignVertical.center,
                  controller: addressController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        left: 20.0, top: 20.0, bottom: 20.0, right: 20.0),
                    isDense: false,
                    filled: true,
                    fillColor: secondaryColor,
                    labelText: 'Enter Address',
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
              ),

              Padding(
                padding: EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
                child: GestureDetector(
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
              ),

              Padding(
                padding: EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
                child: GestureDetector(
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
              ),

              Padding(
                padding: EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 20.0, bottom: 40.0),
                child: MultiSelectDropDown(
                  borderColor: primaryTextColor,
                  hint: "Select Players",
                  hintStyle: TextStyle(
                      fontFamily: 'railway',
                      fontSize: ScreenUtil().setHeight(12),
                      fontWeight: FontWeight.normal,
                      color: primaryTextColor),
                  onOptionSelected: onOptionSelected,
                  options: multiSelectOptions,
                  selectionType: SelectionType.multi,
                  chipConfig: const ChipConfig(wrapType: WrapType.scroll, backgroundColor: appColor, autoScroll: true, ),
                  borderRadius: 5.0,
                  dropdownHeight: 650,
                  optionTextStyle: TextStyle(
                      fontFamily: 'railway',
                      fontSize: ScreenUtil().setHeight(12),
                      fontWeight: FontWeight.normal,
                      color: primaryTextColor),
                  selectedOptionIcon: const Icon(Icons.check_circle),
                ),
              ),

              isloading
                  ? Center(
                child: CircularProgressIndicator(
                  color: appColor,
                ),
              )
                  :
              Padding(
                padding: EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
                child: GestureDetector(
                    onTap: () {
                      addHostGameApi();
                    },
                    child: RoundedButton(text: "Host", press: () {})),
              )

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

  Future<void> getPlayersList() async {
    prefs = await SharedPreferences.getInstance();
    //print((int.parse(bidValueController.text)*100)/int.parse(contestPrice));
    setState(() {
      isloading = true;
    });
    var uri = Uri.https(
      apiBaseUrl,
      '/api/allplayer',
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
    print("All Players Response::$responseBody");
    if (statusCode == 200) {
      if (getdata["success"]) {
        getAllPlayerData = GetAllPlayerData.fromJson(jsonDecode(responseBody));
        playerList!.addAll(getAllPlayerData.data!);

        getAllPlayerData = GetAllPlayerData.fromJson(jsonDecode(responseBody));
        // Clear existing playerList and add new data
        playerList = getAllPlayerData.data;

        // Convert PlayerList to ValueItem
        multiSelectOptions = playerList!
            .map((player) => ValueItem(
          label: player.name ?? 'Default Label',
          value: player.id.toString() ?? 'Default Value',
        ))
            .toList();

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

  Future<void> addHostGameApi() async {
    setState(() {
      isloading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final uri = Uri.parse('https://pokerprosuite.com/api/hostgame');
    //  var url = Uri.http(uri, '/api/createUser');
    //- ---------------------------------------------------------
    var request = new http.MultipartRequest("POST", uri);
    request.headers['Authorization'] = 'Bearer ${prefs.getString('token')}';
    request.fields['address'] = addressController.text;
    request.fields['time'] = timeinput.text;
    request.fields['date'] = dateInput.text;
    request.fields['player_id'] = json.encode(selectedPlayerIds);
    request.fields['mobile'] = "${prefs.getString('mobile')}";
    request.fields['description'] = "";

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
            Message(context, "Host Game successfully.");

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
