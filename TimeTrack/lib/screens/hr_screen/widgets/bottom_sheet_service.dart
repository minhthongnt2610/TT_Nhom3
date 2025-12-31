import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:share_plus/share_plus.dart';

import '../../../contains/app_colors.dart';

class BottomSheetService extends StatelessWidget {
  const BottomSheetService({super.key, required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    int height = MediaQuery.of(context).size.height.toInt();
    int width = MediaQuery.of(context).size.width.toInt();

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.3,
      minChildSize: 0.25,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: const BoxDecoration(
            color: AppColors.backgroundAppBar,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),

          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 50 * width / 440,
                  height: 5 * height / 956,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5 * height / 956),
                  ),
                ),

                const Text(
                  'Chọn dịch vụ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'balooPaaji',
                  ),
                ),

                SizedBox(height: 20 * height / 956),

                ElevatedButton(
                  onPressed: () async {
                    await OpenFilex.open(path);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 55 * height / 956),
                  ),
                  child: Text(
                    'Xem file excel',
                    style: TextStyle(
                      fontSize: 16 * height / 956,
                      fontFamily: 'balooPaaji',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 10 * height / 956),

                ElevatedButton(
                  onPressed: () {
                    Share.shareXFiles([XFile(path)]);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 55 * height / 956),
                  ),
                  child: Text(
                    'Chia sẻ',
                    style: TextStyle(
                      fontSize: 16 * height / 956,
                      fontFamily: 'balooPaaji',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
