import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timetrack/screens/common_screens/widgets/open_street_map.dart';
import 'package:timetrack/screens/employee_screens/checkin_out_screen/widgets/app_bar_widget.dart';
import 'package:timetrack/screens/employee_screens/checkin_out_screen/widgets/bottom_sheet_widget.dart';
import 'package:timetrack/screens/employee_screens/checkin_out_screen/widgets/check_button.dart';
import 'package:timetrack/screens/employee_screens/checkin_out_screen/widgets/clock_widget.dart';
import 'package:timetrack/screens/employee_screens/checkin_out_screen/widgets/event_button.dart';
import 'package:timetrack/screens/employee_screens/dialogs/check_out_success_dialog.dart';
import '../../../contains/app_colors.dart';
import '../dialogs/check_in_success_dialog.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  String _address = "Đang tải địa chỉ...";
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

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetWidget();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    int height = MediaQuery.of(context).size.height.toInt();
    int width = MediaQuery.of(context).size.width.toInt();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarWidget(isCheck: isCheck),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: AppColors.backgroundColor),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 241 * height / 956),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    EventButton(
                      onTap: () {
                        debugPrint("Quản lý đơn từ");
                        _showBottomSheet();
                      },
                      urlImage: "assets/images/icon/DonXinChamCongBoSung.png",
                      text: "Quản lý đơn từ",
                    ),
                    EventButton(
                      onTap: () {
                        debugPrint("Lịch sử chấm công");
                      },
                      urlImage: "assets/images/icon/LichSuChamCong.png",
                      text: "Lịch sử\nchấm công",
                    ),
                    EventButton(
                      onTap: () {
                        debugPrint("Trạng thái đơn");
                      },
                      urlImage: "assets/images/icon/TrangThaiDon.png",
                      text: "Trạng thái\n",
                    ),
                  ],
                ),
                SizedBox(height: 46 * height / 956),
                CheckButton(
                  onPressed: () {
                    setState(() {
                      isCheck = !isCheck;
                    });
                    isCheck ? debugPrint("CHECK IN") : debugPrint("CHECK OUT");
                    isCheck
                        ? checkInSuccessDialog(context)
                        : checkOutSuccessDialog(context);
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
                SizedBox(height: 5 * height / 956),
                Text(
                  "Đ/c: $_address",
                  style: TextStyle(
                    fontSize: 17 * height / 956,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10 * height / 956),
                Container(
                  width: 353 * width / 440,
                  height: 156 * height / 956,
                  child: OpenStreetMap(onChangeAddress: (address) {
                    setState(() {
                      _address = address!;
                    });
                  },),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
