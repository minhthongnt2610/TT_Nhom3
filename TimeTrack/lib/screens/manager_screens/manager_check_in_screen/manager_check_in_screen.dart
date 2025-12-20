import 'package:flutter/material.dart';
import 'package:timetrack/data/remote/firebase/auth_service.dart';
import 'package:timetrack/data/remote/firebase/firestore_service.dart';
import 'package:timetrack/screens/common_screens/history_check_in_out_screen/history_check_in_out_screen.dart';
import 'package:timetrack/screens/common_screens/widgets/bottom_sheet_widget.dart';
import 'package:timetrack/screens/common_screens/widgets/check_button.dart';
import 'package:timetrack/screens/common_screens/widgets/clock_widget.dart';
import 'package:timetrack/screens/common_screens/widgets/event_button.dart';
import 'package:timetrack/screens/common_screens/widgets/open_street_map.dart';
import 'package:timetrack/screens/manager_screens/list_employee_of_department_screen/list_employee_of_department_screen.dart';

import '../../../contains/app_colors.dart';
import '../../../data/remote/firebase/function_service.dart';
import '../../common_screens/dialogs/check_in_fail_dialog.dart';
import '../../common_screens/dialogs/check_in_success_dialog.dart';
import '../../common_screens/dialogs/check_out_success_dialog.dart';
import '../../common_screens/widgets/app_bar_widget.dart';

class ManagerCheckInScreen extends StatefulWidget {
  const ManagerCheckInScreen({super.key});

  @override
  State<ManagerCheckInScreen> createState() => _ManagerCheckInScreenState();
}

class _ManagerCheckInScreenState extends State<ManagerCheckInScreen> {
  String _address = "Đang tải địa chỉ...";
  ClockWidget clockWidget = ClockWidget();
  late String _currentTime;
  late String _currentDate;
  bool isCheck = false;
  final firestoreService = FirestoreService();
  final authService = AuthService();
  double? _lat;
  double? _lon;
  final functionService = FunctionService();

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

    return FutureBuilder(
      future: firestoreService.getUser(authService.currentUser!.uid),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        final user = snapshot.data!;
        final role = user.vaiTro;
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBarWidget(isCheck: isCheck, name: user.hoTen),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(color: AppColors.backgroundColor),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 241 * height / 956),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        EventButton(
                          onTap: () {
                            debugPrint("Quản lý đơn từ");
                            _showBottomSheet();
                          },
                          urlImage:
                              "assets/images/icon/DonXinChamCongBoSung.png",
                          text: "Quản lý\nđơn từ",
                        ),
                        EventButton(
                          onTap: () {
                            debugPrint("Lịch sử chấm công");
                            firestoreService.getUser(
                              authService.currentUser!.uid,
                            );
                            debugPrint(authService.currentUser!.uid);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => LichSuChamCongScreen(
                                  uid: authService.currentUser!.uid,
                                ),
                              ),
                            );
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
                        EventButton(
                          onTap: () {
                            debugPrint("Danh sách nhân viên");
                            if (role == "quanly") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ListEmployeeOfDepartmentScreen(
                                        uid: authService.currentUser!.uid,
                                      ),
                                ),
                              );
                            }
                          },
                          urlImage: "assets/images/icon/document.png",
                          text: "Danh sách\nnhân viên",
                        ),
                      ],
                    ),
                    SizedBox(height: 46 * height / 956),
                    CheckButton(
                      onPressed: () async {
                        debugPrint(
                          "LAT" + _lat.toString() + "LON" + _lon.toString(),
                        );
                        if (_lat == null || _lon == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Không lấy được vị trí GPS"),
                            ),
                          );
                          return;
                        }
                        final result = await functionService.chamCong(
                          lat: _lat!,
                          lon: _lon!,
                        );
                        if (!mounted) return;
                        if (result['status'] == 'CheckIn') {
                          setState(() {
                            isCheck = true;
                          });
                          checkInSuccessDialog(context);
                        } else if (result['status'] == 'CheckOut') {
                          setState(() {
                            isCheck = false;
                          });
                          checkOutSuccessDialog(context);
                        } else {
                          checkInFailDialog(context);
                          debugPrint(result['message']);
                        }
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
                    SizedBox(
                      width: 353 * width / 440,
                      height: 156 * height / 956,
                      child: OpenStreetMap(
                        onChangeAddress: (address, lat, lon) {
                          setState(() {
                            _address = address!;
                            _lat = lat;
                            _lon = lon;
                          });
                        },
                        kvLat: _lat ?? 0,
                        kvLon: _lon ?? 0,
                        banKinh: 100,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
