import 'package:flutter/material.dart';

import '../../../contains/app_colors.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    int height = MediaQuery.of(context).size.height.toInt();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(color: AppColors.backgroundColor),
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Nhập email",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.hexD79E4E,
                      fontFamily: 'balooPaaji',
                    ),
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: AppColors.hexD79E4E),
                    ),
                    hintText: "Nhập email",
                    hintStyle: TextStyle(
                      color: AppColors.hexD79E4E,
                      fontFamily: 'balooPaaji',
                    ),
                  ),
                ),
                SizedBox(height: 26 * height / 956,),
                ElevatedButton(
                  onPressed: () {
                    debugPrint("Gửi");
                  },
                  child: Text(
                    'Xác nhận',
                    style: TextStyle(
                      color: AppColors.hexD79E4E,
                      fontFamily: 'balooPaaji',
                    ),
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
