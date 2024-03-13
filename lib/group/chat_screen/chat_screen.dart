import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:poker_income/provider/ColorsInf.dart';
import 'package:poker_income/provider/DarkThemeProvider.dart';
import '/group/chat_screen/chat_screen_view_model.dart';
import '/group/chat_screen/widget/InputBottomBar.dart';
import '/group/chat_screen/widget/header.dart';
import '/group/chat_screen/widget/message_view/message_view.dart';
import '/group/chat_screen/widget/scroll_down_button.dart';
import 'package:poker_income/screen/home/home_screen.dart';
import 'package:poker_income/screen/landing/landing_screen.dart';
import 'package:poker_income/utils/app.dart';
import '/utils/app_state.dart';
import '/utils/color_res.dart';
import '/utils/common_widgets.dart';
import 'package:poker_income/group/chat_screen/widget/message_view/message_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import '../../../main.dart';
import '../../Model/group_model.dart';
import '../../Model/message_model.dart';

AppLifecycleState? appLifeState;

class ChatScreen extends StatefulWidget {
  final GroupModel groupModel;
  final bool isFromHome;

  ChatScreen(this.groupModel, this.isFromHome);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

bool appIsBG = false;

class _ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
  SharedPreferences? prefs;
  DarkThemeProvider ?themeChange;
  ColorsInf ?colorsInf;

  @override
  void initState() {
    super.initState();
    getPreferenecedata();
    print("Chat screen from Group");
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    appLifeState = state;
    if (state == AppLifecycleState.detached ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      print(widget.groupModel.groupId);
      appIsBG = true;
      if (widget.groupModel.groupId != null) {
        chatRoomService.updateLastMessage(
          {"typing_id": null},
          widget.groupModel.groupId,
        );
      }
    }
    chatRoomService.updateLastMessage(
      {"${prefs!.getString("UserId")}_newMessage": 0},
      widget.groupModel.groupId,
    );
  }

  @override
  Widget build(BuildContext context) {
    themeChange = Provider.of<DarkThemeProvider>(context);
    colorsInf = getColor(context);
    return ViewModelBuilder<ChatScreenViewModel>.reactive(
      onModelReady: (model) async {
        model.init(widget.groupModel, widget.isFromHome);
      },
      builder: (context, model, child) {
        return WillPopScope(
          onWillPop: () async {
            if (model.isForwardMode || model.isDeleteMode) {
              model.clearClick();
            } else {
              model.clearNewMessage();
              model.onBack();
            }
            return false;
          },
          child: GestureDetector(
            onTap: () {
              if (model.isAttachment) {
                model.isAttachment = false;
                model.notifyListeners();
              }
            },
            child: StreamBuilder<DocumentSnapshot>(
              stream: groupService.getGroupStream(
                  (widget.groupModel.groupId != null ||
                          widget.groupModel.groupId != "")
                      ? widget.groupModel.groupId
                      : appState.currentActiveRoom),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  model.clearNewMessage();
                  if (snapshot.data.exists) {
                    GroupModel groupData = GroupModel.fromMap(
                        snapshot.data.data(), snapshot.data.id);
                    if (groupData.members
                        .where((element) =>
                            element.memberId == prefs.getString("UserId"))
                        .isEmpty) {
                      Future.delayed(Duration(seconds: 2))
                          .then((value) => model.onBack());
                      return Scaffold(
                        backgroundColor: ColorRes.background,
                        body: Center(
                          child: Text(colorsInf.youHaveRemovedText),
                        ),
                        appBar: AppBar(
                          leading: Container(
                            margin: EdgeInsets.symmetric(horizontal: 13),
                            child: InkWell(
                              onTap: model.onBack,
                              child: Icon(
                                Platform.isIOS
                                    ? Icons.arrow_back_ios
                                    : Icons.arrow_back,
                                color: ColorRes.dimGray,
                              ),
                            ),
                          ),
                          backgroundColor: ColorRes.white,
                          elevation: 0,
                        ),
                      );
                    } else {
                      model.updateGroupInfo(groupData);
                      return Scaffold(
                        backgroundColor: ColorRes.background,
                        appBar: PreferredSize(
                          preferredSize: Size(Get.width, 50),
                          child: Header(
                            groupModel: groupData,
                            onBack: model.onBack,
                            headerClick: () {
                              model.headerClick(colorsInf);
                            },
                            isDeleteMode: model.isDeleteMode,
                            isForwardMode: model.isForwardMode,
                            deleteClick: model.deleteClickMessages,
                            forwardClick: model.forwardClickMessages,
                            clearClick: model.clearClick,
                            prefs: prefs,
                          ),
                        ),
                        body: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            AbsorbPointer(
                              absorbing: model.isAttachment,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: PaginateFirestore(
                                      padding: EdgeInsets.all(10.0),
                                      query: chatRoomService.getMessages(
                                          model.groupModel.groupId,
                                          model.chatLimit),
                                      itemBuilderType:
                                          PaginateBuilderType.listView,
                                      isLive: true,
                                      itemsPerPage: 10,
                                      scrollController:
                                          model.listScrollController,
                                      itemBuilder:
                                          (index, context, documentSnapshot) {
                                        if (!model.listMessage
                                            .contains(documentSnapshot)) {
                                          model.listMessage
                                              .add(documentSnapshot);
                                        }
                                        return MessageView(
                                            index,
                                            MessageModel.fromMap(
                                              documentSnapshot.data(),
                                              documentSnapshot.id,
                                            ),
                                            model.downloadDocument,
                                            model.selectedMessages,
                                            model.onTapPressMessage,
                                            model.onLongPressMessage,
                                            model.isDeleteMode,
                                            model.isForwardMode,
                                            prefs.getString("UserId"));
                                      },
                                      emptyDisplay: Center(
                                        child: Text(colorsInf.sendMessege),
                                      ),
                                      reverse: true,
                                    ),
                                  ),
                                  InputBottomBar(
                                    msgController: model.controller,
                                    onTextFieldChange: model.onTextFieldChange,
                                    onCameraTap: model.onCameraTap,
                                    onSend: model.onSend,
                                    onMicTap: model.onMicTap,
                                    onMicStop: model.onStop,
                                    message: model.message,
                                    focusNode: model.focusNode,
                                    onAttachment: model.onAttachmentTap,
                                    isTyping: model.isTyping,
                                    clearReply: model.clearReply,
                                    colorsInf: colorsInf,
                                  ),
                                ],
                              ),
                            ),
                            SafeArea(
                              child: AnimatedOpacity(
                                opacity: model.isAttachment ? 1 : 0,
                                duration: Duration(milliseconds: 500),
                                child: model.isAttachment
                                    ? AttachmentView(
                                        onGalleryTap: model.onGalleryTap,
                                        onAudioTap: model.onAudioTap,
                                        onVideoTap: model.onVideoTap,
                                        onDocumentTap: model.onDocumentTap,
                                        colorsInf: colorsInf,
                                      )
                                    : Container(),
                              ),
                            ),
                            model.showScrollDownBtn
                                ? Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 60),
                                      child: ScrollDownButton(
                                        onTap: model.onScrollDownTap,
                                      ),
                                    ),
                                  )
                                : Container(),
                            model.uploadingMedia
                                ? Container(
                                    height: Get.height,
                                    width: Get.width,
                                    color: ColorRes.dimGray.withOpacity(0.3),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Platform.isIOS
                                            ? CupertinoActivityIndicator()
                                            : CircularProgressIndicator(),
                                        verticalSpaceSmall,
                                        Text(colorsInf.uploadingMeadiaText)
                                      ],
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      );
                    }
                  } else {
                    Future.delayed(Duration(seconds: 2))
                        .then((value) => model.onBack());
                    return Scaffold(
                      backgroundColor: ColorRes.background,
                      body: Center(
                        child: Text(colorsInf.groupDeletedText),
                      ),
                      appBar: AppBar(
                        leading: Container(
                          margin: EdgeInsets.symmetric(horizontal: 13),
                          child: InkWell(
                            onTap: model.onBack,
                            child: Icon(
                              Platform.isIOS
                                  ? Icons.arrow_back_ios
                                  : Icons.arrow_back,
                              color: ColorRes.dimGray,
                            ),
                          ),
                        ),
                        backgroundColor: ColorRes.white,
                        elevation: 0,
                      ),
                    );
                  }
                } else {
                  return Scaffold(
                    backgroundColor: ColorRes.background,
                    appBar: PreferredSize(
                      preferredSize: Size(Get.width, 50),
                      child: Header(
                        groupModel: widget.groupModel,
                        onBack: model.onBack,
                        headerClick: () {
                          model.headerClick(colorsInf);
                        },
                        isDeleteMode: model.isDeleteMode,
                        isForwardMode: model.isForwardMode,
                        deleteClick: model.deleteClickMessages,
                        forwardClick: model.forwardClickMessages,
                        clearClick: model.clearClick,
                      ),
                    ),
                    body: Center(
                      child: Platform.isIOS
                          ? CupertinoActivityIndicator()
                          : CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
      viewModelBuilder: () => ChatScreenViewModel(),
    );
  }

  Future<void> getPreferenecedata() async {
    prefs = await SharedPreferences.getInstance();
  }
}
