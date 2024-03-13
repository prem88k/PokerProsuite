import 'package:flutter/material.dart';

import '../../../../utils/color_res.dart';
import '../../../../utils/styles.dart';


class UserCard extends StatelessWidget {
  CategoryData user;

  UserCard({
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //todo
          // image Commented
    /*      Container(
            height: 40,
            width: 40,
            margin: EdgeInsets.only(bottom: 3),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: Image.network(
                user.profileImage,
                height: 40,
                width: 40,
              ),
            ),
          ),*/
          Text(
            user.username.split(" ").first,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle(
              color: ColorRes.black,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
