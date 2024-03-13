import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:planty_connect/model/ContactList.dart';
import 'package:planty_connect/model/room_model.dart';
import 'package:planty_connect/model/send_notification_model.dart';
import 'package:planty_connect/model/user_model.dart';
import 'package:planty_connect/screen/broadcast/new_group/add_description/add_description.dart';
import 'package:planty_connect/screen/group/new_group/add_description/add_description.dart';
import 'package:planty_connect/screen/group/new_group/add_description/add_description.dart';
import 'package:planty_connect/screen/home/home_screen.dart';
import 'package:planty_connect/service/chat_room_service/chat_room_service.dart';
import 'package:planty_connect/utils/app.dart';
import 'package:planty_connect/utils/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class SelectMembersViewModel extends BaseViewModel {
  List<UserModel> users = [];
  List<CategoryData> selectedMembers = [];
  bool isGroup;

  init(bool isGroup) async {
    this.isGroup = isGroup;

    setBusy(true);
    await addUsersInList().then((value) {
      setBusy(false);
    });
  }

  Future<void> addUsersInList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    QuerySnapshot querySnapshot = await userService.getUsers();
    if (querySnapshot.docs.isNotEmpty) {
      List<UserModel> totalUsers =
          querySnapshot.docs.map((e) => UserModel.fromMap(e.data())).toList();

      if (isGroup) {
        users = totalUsers;
      } else {
        List<RoomModel> filterUserList = [];
        ChatRoomService().getCurrentUserRooms(prefs).listen((event) {
          event.docs.forEach((element) {
            filterUserList.add(RoomModel.fromMap(element.data()));
          });
          totalUsers.forEach((element) {
            bool flag = false;
            for (int i = 0; i < filterUserList.length; i++) {
              if (filterUserList[i].membersId.contains(element.uid)) {
                flag = true;
                break;
              }
            }
            if (flag == false) {
              users.add(element);
            }
          });
          notifyListeners();
        });
      }
    } else {
      users = [];
    }
  }

  void nextClick() {
    print("Group click");

    if (selectedMembers.isEmpty) {
      showErrorToast(AppRes.select_at_least_one_member);
    } else {
      Get.to(() => AddDescription(selectedMembers));
    }
  }
  void nextBroadcastClick() {
    print("broadcast click");
    if (selectedMembers.isEmpty) {
      showErrorToast(AppRes.select_at_least_one_member);
    } else {
      Get.to(() => AddBroadcastDescription(selectedMembers));
    }
  }
  bool isSelected(CategoryData userModel) {
    return selectedMembers.contains(userModel);
  }

  void selectUserClick(CategoryData user, [String s]) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (isGroup) {
      if (selectedMembers.contains(user))
        selectedMembers.remove(user);
      else
        selectedMembers.add(user);

      notifyListeners();
    } else {
      setBusy(true);
      String chatId = '';
      if (user.userId.hashCode <= prefs.getString("UserId").hashCode) {
        chatId = '${user.userId}-${prefs.getString("UserId").hashCode}';
      } else {
        chatId = '${prefs.getString("UserId").hashCode}-${user.userId}';
      }
      await chatRoomService.createChatRoom({
        "isGroup": false,
        "id": chatId,
        "membersId": [prefs.getString("UserId"), user.userId],
        "membersName": [prefs.getString("Username"),user.username],
        "memberImage":"",
        "senderImage":"",
        "createdBy":prefs.getString("UserId"),
        "lastMessage": "Tap here",
        "${prefs.getString("UserId")}_typing": false,
        "${user.userId}_typing": false,
        "${prefs.getString("UserId")}_newMessage": 0,
        "${user.userId}_newMessage": 1,
        "lastMessageTime": DateTime.now(),
        "fcmToken":await FirebaseMessaging.instance.getToken(),
        "blockBy": null,
      });

      SendNotificationModel sendNotificationModel = SendNotificationModel(
        fcmToken: await FirebaseMessaging.instance.getToken(),
        roomId: chatId,
        id: prefs.getString("UserId"),
        body: "Tap here to chat",
        title: "${user.username} send you a message",
        isGroup: false,
      );
      // ignore: unnecessary_statements
      ("fsdklfjskljfklfjskfjfsdjfsdkldflf"!= await FirebaseMessaging.instance.getToken()) ? messagingService.sendNotification(sendNotificationModel) : null;
      Get.offAll(() => HomeScreen());
    }
  }
}
