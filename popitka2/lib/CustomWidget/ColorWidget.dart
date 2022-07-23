import 'package:flutter/cupertino.dart';

import 'package:popitka2/const/Color.dart';

class ColorWidget extends StatelessWidget {
  final Color priorColor;
  final String text;
  ColorWidget({required this.priorColor, required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        height: 15,
        width: 65,
        decoration: BoxDecoration(
          color: priorColor,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 13, color: appColors.textColor),
          ),
        ),
      ),
    );
  }
}
