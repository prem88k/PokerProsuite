import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poker_income/Model/message_model.dart';
import 'package:poker_income/group/chat_screen/widget/message_view/text_message.dart';

import 'package:poker_income/utils/app_state.dart';
import 'package:poker_income/utils/color_res.dart';

import 'alert_message.dart';
import 'document_message.dart';
import 'image_message.dart';

class MessageView extends StatelessWidget {
  final int index;
  final MessageModel message;
  final Function(String, String) downloadDocument;
  final Function(MessageModel, bool) onLongPress;
  final Function(MessageModel) onTapPress;
  final List<MessageModel> selectedMessages;
  final bool forwardMode;
  final bool deleteMode;
  String? userId;

  MessageView(
    this.index,
    this.message,
    this.downloadDocument,
    this.selectedMessages,
    this.onTapPress,
    this.onLongPress,
    this.deleteMode,
    this.forwardMode, [this.userId]
  );

  @override
  Widget build(BuildContext context) {
    final bool contains = selectedMessages
        .where((element) => element.id == message.id)
        .isNotEmpty;
    final bool sender = message.sender == userId;
    return GestureDetector(
      onLongPress: forwardMode || deleteMode || message.type == "alert"
          ? null
          : () {
              onLongPress.call(message, sender);
            },
      onTap: () {
        if (forwardMode && message.type != 'alert') {
          onTapPress.call(message);
        } else if (deleteMode) {
          if (sender && message.type != 'alert') {
            onTapPress.call(message);
          }
        }
      },
      child: Stack(
        alignment: sender ? Alignment.centerRight : Alignment.centerLeft,
        children: [
          message.type == "text"
              ? TextMessage(
                  message,
                  sender,
                )
              : message.type == "alert"
                      ? AlertMessage(message.content!)
                      : DocumentMessage(
                          message!,
                          downloadDocument,
                          sender,
                          forwardMode || deleteMode,
                        ),
          contains
              ? Positioned.fill(
                  child: Container(
                    width: Get.width,
                    constraints: BoxConstraints(
                      minHeight: 30,
                    ),
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: sender
                          ? BorderRadius.only(
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12))
                          : BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12)),
                      color: ColorRes.green.withOpacity(0.3),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
