import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../contains/app_colors.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key, required this.isCheck});
  final bool isCheck;
  @override
  Widget build(BuildContext context) {
    int height = MediaQuery.of(context).size.height.toInt();
    int width = MediaQuery.of(context).size.width.toInt();

    final appbar = AppBar(
      backgroundColor: AppColors.backgroundAppBar,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25 * height / 956),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            greet(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textAppBar,
              fontSize: 20,
              fontFamily: GoogleFonts.balooPaaji2().fontFamily,
            ),
          ),
          Text(
            "Phạm Lê Huyền Trân",
            style: TextStyle(
              color: AppColors.textAppBar,
              fontWeight: FontWeight.bold,
              fontSize: 26,
              fontFamily: GoogleFonts.balooPaaji2().fontFamily,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 15 * width / 440),
          child: Stack(
            children: [
              ClipOval(
                child: Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      debugPrint("Thông báo");
                    },
                    child: SizedBox(
                      width: 50 * width / 440,
                      height: 50 * height / 956,
                      child: Image(
                        image: AssetImage(
                          "assets/images/logo_login_screen.png",
                        ),
                        width: 50 * width / 440,
                        height: 50 * height / 956,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 14.0 * width / 440,
                  height: 14.0 * width / 440,
                  decoration: BoxDecoration(
                    color: isCheck ? Colors.green : Colors.grey,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
    return Stack(
      children: [
        appbar,
        Positioned(
          bottom: 15,
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColors.textAppBar),
              ),
              onPressed: () {},
              child: Text(
                "Thông tin cá nhân",
                style: TextStyle(
                  color: AppColors.backgroundAppBar,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.balooPaaji2().fontFamily,
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
  Size get preferredSize => Size.fromHeight(140);
}
