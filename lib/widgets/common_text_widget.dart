import 'package:flutter/material.dart';



class CommonTextWidget extends StatelessWidget {
  final String textString;
  final Color? textColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? letterSpacing;
  final TextAlign? textAlign;
  final TextStyle? textStyle;
  final double leftPadding;
  final double rightPadding;
  final double topPadding;
  final double bottomPadding;

  const CommonTextWidget({
    super.key,
    required this.textString,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.letterSpacing,
    this.textAlign,
    this.textStyle,
    this.leftPadding = 0,
    this.rightPadding = 0,
    this.topPadding = 0,
    this.bottomPadding = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          leftPadding, topPadding, rightPadding, bottomPadding),
      child: Text(
        textString,
        textAlign: textAlign,
        style: textStyle ??
            TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
              letterSpacing: letterSpacing,
            ),
      ),
    );
  }
}
