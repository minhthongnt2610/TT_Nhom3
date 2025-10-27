import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timetrack/screens/employee_screens/widgets/app_bar_widget.dart';
import 'package:timetrack/screens/employee_screens/widgets/check_button.dart';
import 'package:timetrack/screens/employee_screens/widgets/clock_widget.dart';
import 'package:timetrack/screens/employee_screens/widgets/event_button.dart';

import '../../contains/app_colors.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  ClockWidget clockWidget = ClockWidget();
  late String _currentTime;
  late String _currentDate;
  bool isCheck = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentTime = clockWidget.getCurrentTime();
    _currentDate = clockWidget.getCurrentDate();
    clockWidget.startTime(() {
      setState(() {
        _currentTime = clockWidget.getCurrentTime();
        _currentDate = clockWidget.getCurrentDate();
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    clockWidget.timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    int height = MediaQuery.of(context).size.height.toInt();
    int width = MediaQuery.of(context).size.width.toInt();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarWidget(isCheck: isCheck,),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 241 * height / 956),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    EventButton(
                      onTap: () {},
                      urlImage: "assets/images/icon/DonXinChamCongBoSung.png",
                      text: "Đơn xin chấm\ncông bổ sung",
                    ),
                    EventButton(
                      onTap: () {},
                      urlImage: "assets/images/icon/DonXinNghiPhep.png",
                      text: "Đơn xin\nnghỉ phép",
                    ),
                    EventButton(
                      onTap: () {},
                      urlImage: "assets/images/icon/LichSuChamCong.png",
                      text: "Lịch sử\nchấm công",
                    ),
                    EventButton(
                      onTap: () {},
                      urlImage: "assets/images/icon/TrangThaiDon.png",
                      text: "Trạng thái\n",
                    ),
                  ],
                ),
                SizedBox(height: 46 * height / 956),
                CheckButton(
                  onPressed: () {
                    debugPrint('Check in');
                    setState(() {
                      isCheck = !isCheck;
                    });
                  },
                  nameButton: isCheck ? "CHECK OUT" : "CHECK IN",
                ),
                SizedBox(height: 46 * height / 956),
                Text(
                  _currentTime,
                  style: TextStyle(
                    fontSize: 29 * height / 956,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  _currentDate,
                  style: TextStyle(
                    fontSize: 20 * height / 956,
                    color: Colors.black,
                    fontFamily: 'balooPaaji',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
