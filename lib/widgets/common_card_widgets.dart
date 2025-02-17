import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_size.dart';

class CommonCardWidgets extends StatefulWidget {
  final double topleftBorderRadias;
  final double topRightBorderRadias;
  final double bottomLeftBorderRadias;
  final double bottomRightBorderRadias;
  final double leftPadding;
  final double topMargin;
  final double topPadding;
  final double rightPadding;
  final double bottomPadding;
  final double bottomMargin;
  final double? screenWidth;
  final Gradient? gradient;
  final Color? cardColor;

  final Widget widget;
  const CommonCardWidgets({
    super.key,
    this.topleftBorderRadias = 0,
    this.topRightBorderRadias = 0,
    this.bottomLeftBorderRadias = 0,
    this.bottomRightBorderRadias = 0,
    this.topMargin = 0,
    this.leftPadding = 0,
    this.topPadding = 0,
    this.rightPadding = 0,
    this.bottomPadding = 0,
    this.bottomMargin = 0,
    this.screenWidth,
    this.gradient,
    this.cardColor,
    required this.widget,
  });
  @override
  State<CommonCardWidgets> createState() => _CommonCardWidgetsState();
}

class _CommonCardWidgetsState extends State<CommonCardWidgets> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.screenWidth ?? AppWidgetSize.screenWidth(context),
      decoration: ShapeDecoration(
        color: widget.cardColor,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(widget.topleftBorderRadias.r),
            topRight: Radius.circular(widget.topRightBorderRadias.r),
            bottomLeft: Radius.circular(widget.bottomLeftBorderRadias.r),
            bottomRight: Radius.circular(widget.bottomRightBorderRadias.r),
          ),
        ),
      ),
      margin: REdgeInsets.only(
        top: widget.topMargin,
        bottom: widget.bottomMargin,
      ),
      padding: REdgeInsets.only(
        left: widget.leftPadding,
        right: widget.rightPadding,
        top: widget.topPadding,
        bottom: widget.bottomPadding,
      ),
      child: widget.widget,
    );
  }
}
