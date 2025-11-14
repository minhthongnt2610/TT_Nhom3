import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventButton extends StatelessWidget {
  EventButton({
    super.key,
    required this.onTap,
    required this.urlImage,
    required this.text,
  });
  final VoidCallback onTap;
  final String urlImage;
  final String text;

  @override
  Widget build(BuildContext context) {
    int height = MediaQuery.of(context).size.height.toInt();
    int width = MediaQuery.of(context).size.width.toInt();
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: SizedBox(
            width: 50 * width / 440,
            height: 50 * height / 956,
            child: Image(
              image: AssetImage(urlImage),
              width: 50 * width / 440,
              height: 50 * height / 956,
            ),
          ),
        ),
        SizedBox(height: 4 * height / 956),
        Text(
          text,
          style: TextStyle(
            fontFamily: 'balooPaaji',
            fontSize: 12,
            color:Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
