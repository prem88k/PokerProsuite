import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:planty_connect/model/group_model.dart';
import 'package:planty_connect/provider/ColorsInf.dart';
import 'package:planty_connect/screen/group/group_details/group_details_view_model.dart';
import 'package:planty_connect/utils/color_res.dart';
import 'package:planty_connect/utils/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MembersCard extends StatelessWidget {
  final List<GroupMember> groupMembers;
  final GroupDetailsViewModel model;
  SharedPreferences prefs;
  ColorsInf colorsInf;

  MembersCard(this.groupMembers, this.model, this.prefs, this.colorsInf);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: groupMembers.length,
      shrinkWrap: true,
      padding: EdgeInsets.all(0),
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            if (groupMembers[index].memberId != prefs.getString("UserId")) {
              model.groupMembersTap.call(
                groupMembers[index],
                groupMembers
                    .firstWhere((element) =>
                        element.memberId == prefs.getString("UserId"))
                    .isAdmin,
                model,
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            /*    Container(
                  height: 40,
                  width: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.network(
                      groupMembers[index].memberImage,
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),*/
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    width: Get.width,
                    child: Text(
                      groupMembers[index].memberId == prefs.getString("UserId")
                          ? "You"
                          : groupMembers[index].memberName,
                      style: AppTextStyle(
                        color: ColorRes.black,
                        fontSize: 16,
                        weight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                groupMembers[index].isAdmin
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorRes.green),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          colorsInf.adminText,
                          style: AppTextStyle(
                            color: ColorRes.green,
                            fontSize: 14,
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    );
  }
}
