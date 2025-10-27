import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../contains/app_colors.dart';

class CheckButton extends StatefulWidget {
  const CheckButton({
    super.key,
    required this.onPressed,
    required this.nameButton,
  });
  final VoidCallback onPressed;
  final String nameButton;

  @override
  State<CheckButton> createState() => _CheckButtonState();
}

class _CheckButtonState extends State<CheckButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<Color?> _glow;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );

    _scale = Tween<double>(
      begin: 1,
      end: 0.8,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _glow = ColorTween(
      begin: Colors.orange.withOpacity(0.2),
      end: Colors.orange.withOpacity(0.6),
    ).animate(_controller);
  }

  void _onTapUp(TapUpDetails details) async {
    await Future.delayed(Duration(milliseconds: 100));
    _controller.reverse();
    widget.onPressed();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    int height = MediaQuery.of(context).size.height.toInt();
    int width = MediaQuery.of(context).size.width.toInt();
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scale.value,
            child: Container(
              width: 223 * width / 440,
              height: 223 * height / 956,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.backgroundColor, AppColors.backgroundButton],
                ),
                borderRadius: BorderRadius.circular(112 * height / 956),
                border: Border.all(
                  color: AppColors.borderButton,
                  width: 5 * height / 956,
                ),
                boxShadow: [
                  BoxShadow(
                    color: _glow.value ?? Colors.transparent,
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                widget.nameButton,
                style: TextStyle(

                  fontSize: 35,
                  color: Colors.black,
                  fontFamily: 'balooPaaji',
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
