import 'package:flutter/material.dart';
import 'package:timetrack/screens/employee_screens/widgets/app_bar_widget.dart';
import 'package:timetrack/screens/employee_screens/widgets/event_button.dart';

import '../../contains/app_colors.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  @override
  Widget build(BuildContext context) {
    int height = MediaQuery.of(context).size.height.toInt();
    int width = MediaQuery.of(context).size.width.toInt();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarWidget(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.hexFFF0F0, AppColors.hexD42C42],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 241 * height / 956),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  EventButton(
                    onTap: () {},
                    urlImage: "assets/logo/logo.png",
                    text: "Đơn xin chấm\ncông bổ sung",
                  ),
                  EventButton(
                    onTap: () {},
                    urlImage: "assets/logo/logo.png",
                    text: "Đơn xin\nnghỉ phép",
                  ),
                  EventButton(
                    onTap: () {},
                    urlImage: "assets/logo/logo.png",
                    text: "Lịch sử\nchấm công",
                  ),
                  EventButton(
                    onTap: () {},
                    urlImage: "assets/logo/logo.png",
                    text: "Trạng thái\n",
                  ),
                ],
              ),
              SizedBox(height: 46 * height / 956),
              GestureDetector(
                onTap: (){
                  print("Check in");
                },
                child: Container(
                  width: 223 * width / 440,
                  height: 223 * height / 956,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [AppColors.hexFFFBFE, AppColors.hexFFE699],
                    ),
                    borderRadius: BorderRadius.circular(112 * height / 956),
                    border: Border.all(
                      color: AppColors.hexF8790A,
                      width: 5 * height / 956,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "CHECK IN",
                    style: TextStyle(fontSize: 40, color: AppColors.hexF8790A,),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
