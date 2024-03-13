import 'package:flutter/material.dart';
import 'package:planty_connect/model/ContactList.dart';
import 'package:planty_connect/model/user_model.dart';
import 'package:planty_connect/utils/color_res.dart';
import 'package:planty_connect/utils/styles.dart';

class UserCard extends StatelessWidget {
  CategoryData user;
  final Function(CategoryData) onTap;

  UserCard({
    @required this.onTap,
    @required this.isSelected, this.user,
  });

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap.call(user);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //todo
              // image Commented
              /*  Container(
                height: 40,
                width: 40,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.network(
                    user.profilePicture,
                    height: 40,
                    width: 40,
                  ),
                ),
              ),*/
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.username,
                        style: AppTextStyle(
                          color: ColorRes.black,
                          fontSize: 16,
                          weight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "",
                        style: AppTextStyle(
                          color: ColorRes.grey.withOpacity(0.5),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              isSelected
                  ? Icon(
                Icons.check_circle,
                color: ColorRes.green,
              )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
