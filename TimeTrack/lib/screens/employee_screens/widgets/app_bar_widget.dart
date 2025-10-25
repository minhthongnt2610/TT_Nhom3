import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../contains/app_colors.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    int height = MediaQuery.of(context).size.height.toInt();
    int width = MediaQuery.of(context).size.width.toInt();
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            greet(),
            style: TextStyle(color: Colors.white,fontSize: 20 ),
          ),
          Text(
            "Nguyễn Minh Thông",
            style: TextStyle(color: Colors.white,fontSize: 26),
          ),
        ],
      ),
      flexibleSpace: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.hexF9C752,
              AppColors.hexFF3846,
              AppColors.hexFF1275,
            ],
          ),
          borderRadius: BorderRadius.circular(25 * height / 956),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 15 * width / 440),
          child: ClipOval(
            child: Material(
              color: Colors.blue,
              child: InkWell(
                onTap: () {
                  print("Thông báo");
                },
                child: SizedBox(
                  width: 50 * width / 440,
                  height: 50 * height / 956,
                  child: Image(
                    image: AssetImage("assets/logo/logo.png"),
                    width: 50 * width / 440,
                    height: 50 * height / 956,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String greet() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "Chào buổi sáng!";
    } else if (hour < 17) {
      return "Chào buổi chiều!";
    } else {
      return "Chào buổi tối!";
    }
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(120);
}
