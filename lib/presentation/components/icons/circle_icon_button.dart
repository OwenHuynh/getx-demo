import 'package:demo_getx_flutter/presentation/theme/colors.dart';
import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  CircleIconButton(
      {this.size = 17.0, this.icon = Icons.clear, required this.onPressed});

  final double size;
  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: SizedBox(
            width: size,
            height: size,
            child: Stack(
              alignment: Alignment(0, 0), // all centered
              children: <Widget>[
                Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.colorGreyIcon),
                ),
                Icon(
                  icon,
                  color: AppColors.white,
                  size: size * 0.8, // 60% width for icon
                )
              ],
            )));
  }
}
