import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_size.dart';

class CommonTextFieldWidget extends StatefulWidget {
  final String hintText;
  final TextStyle? hintTextStyle;
  final TextStyle? textStyle;
  final bool isReadOnly;
  final TextEditingController? textEditingController;
  final Function(String)? onChanged;
  final Function()? onTap;
  const CommonTextFieldWidget(
      {super.key,
      required this.hintText,
      this.hintTextStyle,
      this.textStyle,
      this.textEditingController,
      this.onChanged,
      this.isReadOnly = false,
      this.onTap});

  @override
  State<CommonTextFieldWidget> createState() => _CommonTextFieldWidgetState();
}

class _CommonTextFieldWidgetState extends State<CommonTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(
          Radius.circular(AppWidgetSize.dimen_12.r),
        ),
      ),
      padding: REdgeInsets.only(
          left: AppWidgetSize.dimen_8,
          right: AppWidgetSize.dimen_8,
          top: AppWidgetSize.dimen_5,
          bottom: AppWidgetSize.dimen_5),
      child: TextField(
          controller: widget.textEditingController,
          readOnly: widget.isReadOnly,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*\.?[0-9]*$')),
          ],
          decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: widget.hintText,
            hintStyle: widget.hintTextStyle ??
                TextStyle(
                    fontSize: AppWidgetSize.dimen_12.sp,
                    letterSpacing: 0.4.sp,
                    color: Theme.of(context)
                        .colorScheme
                        .copyWith(primary: const Color(0xFF4D4D4D))
                        .primary),
          ),
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          style: widget.textStyle ??
              TextStyle(
                  fontSize: AppWidgetSize.dimen_14.sp,
                  letterSpacing: 0.4.sp,
                  color: Theme.of(context)
                      .colorScheme
                      .copyWith(primary: const Color(0xFF1f1f1f))
                      .primary)),
    );
  }
}
