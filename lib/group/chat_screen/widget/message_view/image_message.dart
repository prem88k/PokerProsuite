import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poker_income/model/message_model.dart';
import 'package:poker_income/utils/app.dart';
import 'package:poker_income/utils/color_res.dart';
import 'package:poker_income/utils/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageMessage extends StatelessWidget {
  final MessageModel message;
  final bool selectionMode;
  final bool sender;

  ImageMessage(this.message, this.selectionMode, this.sender);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          sender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        sender
            ? Container()
            : Row(
                children: [
                  CircleAvatar(
                    radius: 15.0,
                    backgroundImage: AssetImage(AssetsRes.profileImage),
                    backgroundColor: Colors.transparent,
                  ),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: Get.width / 3,
                      minWidth: Get.width / 4,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Text(
                      message.senderName ?? "Unknown",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle(
                        color: ColorRes.black,
                        weight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
        Container(
          child: Stack(
            children: <Widget>[
              InkWell(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  child: Image.network(
                    message.content!,
                    width: 200.0.h,
                    height: 200.0.h,
                    fit: BoxFit.cover,
                  )
                ),
                onTap: selectionMode
                    ? null
                    : () async {
                        await Get.dialog(
                          Dialog(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.network(
                                  message.content!,
                                  width: 200.0.h,
                                  height: 200.0.h,
                                  fit: BoxFit.cover,
                                )
                              ],
                            ),
                          ),
                        );
                      },
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  child: Text(
                    hFormat(
                        DateTime.fromMillisecondsSinceEpoch(message.sendTime!)),
                    style: AppTextStyle(
                      color: ColorRes.white.withOpacity(0.7),
                      fontSize: 12,
                    ),
                  ),
                  margin: EdgeInsets.only(right: 10, bottom: 5),
                ),
              )
            ],
          ),
          margin: EdgeInsets.only(
            left: sender ? 10 : 0,
            right: sender ? 0 : 10,
            bottom: 10,
          ),
          height: 200.h,
          width: 200.h,
        ),
      ],
    );
  }
}
