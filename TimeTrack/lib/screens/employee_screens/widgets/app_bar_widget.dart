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
      title: Text(
        greet("Nguyễn Minh Thông"),
        style: TextStyle(color: Colors.white),
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
        IconButton(
          onPressed: () {
            print("Thông báo");
          },
          icon: Image(
            image: AssetImage("assets/logo/logo.png"),
            width: 50 * width / 440,
            height: 50 * height / 956,
          ),
        ),
      ],
    );
  }

  String greet(String name) {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "Chào buổi sáng! \n$name";
    } else if (hour < 17) {
      return "Chào buổi chiều! \n$name";
    } else {
      return "Chào buổi tối! \n$name";
    }
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(150);
}
