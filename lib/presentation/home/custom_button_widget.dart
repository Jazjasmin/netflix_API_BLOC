import 'package:flutter/material.dart';
import 'package:netflix_app/core/colors/colors.dart';

class CustomeButtonWidget extends StatelessWidget {
  const CustomeButtonWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.iconSize,
    required this.textSize,
  }) : super(key: key);
  final IconData icon;
  final String title;
  final double iconSize;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: kwhite,
          size: iconSize,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: textSize,
          ),
        ),
      ],
    );
  }
}
