import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dart:ui' as ui;

import '../main.dart';
import '../utils/app_size.dart';
import '../widgets/common_text_widget.dart';

abstract class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<StatefulWidget> createState();
}

abstract class BaseScreenState<Page extends BaseScreen> extends State<Page>
    with RouteAware, WidgetsBindingObserver {
  Widget loaderWidget({color = Colors.deepPurple, msg = ""}) {
    return Container(
      color: color == Colors.deepPurple
          ? Colors.black.withAlpha(150)
          : Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
      child: msg.toString().isNotEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  color: ui.Color(0xFF07A869),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppWidgetSize.bodyPadding),
                  child: Text(msg,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontSize: AppWidgetSize.dimen_16.sp,
                          height: 1.5,
                          color: Theme.of(context).colorScheme.primaryContainer
                          // .withOpacity(0.4)
                          )),
                )
              ],
            )
          : const Center(
              child: CircularProgressIndicator(color: Colors.deepPurple),
            ),
    );
  }

  showErrorMessage(String msg,
      {hideretry = false, seconds = 5, isErrorUI = true}) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    return scaffoldkey.currentState!.showSnackBar(SnackBar(
      duration: Duration(seconds: seconds),
      elevation: AppWidgetSize.dimen_10,
      content: Container(
          padding: REdgeInsets.only(
              left: AppWidgetSize.dimen_20,
              bottom: AppWidgetSize.dimen_20,
              top: AppWidgetSize.dimen_20),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [Color(0xFF282828), Color(0xFF282828)],
                  stops: [AppWidgetSize.dimen_0, AppWidgetSize.dimen_1]),
              borderRadius:
                  BorderRadius.all(Radius.circular(AppWidgetSize.dimen_12))),
          child: Row(
            children: [
              Container(
                width: AppWidgetSize.dimen_25,
                height: AppWidgetSize.dimen_25,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      isErrorUI
                          ? Theme.of(context).colorScheme.error
                          : Colors.green,
                      isErrorUI
                          ? Theme.of(context)
                              .colorScheme
                              .copyWith(error: Colors.red)
                              .error
                          : Colors.green
                    ],
                  ),
                ),
                child: Center(
                  child: isErrorUI
                      ? CommonTextWidget(
                          textString: "!",
                          textColor: Colors.white,
                          fontSize: AppWidgetSize.dimen_15.sp,
                          fontWeight: FontWeight.w900)
                      : Icon(
                          Icons.check,
                          size: AppWidgetSize.dimen_16,
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: REdgeInsets.only(left: AppWidgetSize.dimen_15),
                  child: CommonTextWidget(
                      textString: msg,
                      textColor: Colors.white,
                      fontSize: AppWidgetSize.dimen_14.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          )),
      behavior: SnackBarBehavior.fixed,
      dismissDirection: DismissDirection.horizontal,
      backgroundColor: Colors.transparent,
    ));
  }

  showAlertBottomSheet(
      {String titleText = "",
      String contentText = "",
      String buttonOneText = "",
      String buttonTwoText = "",
      Function()? buttonOneTap,
      Function()? buttonTwoTap}) {
    showModalBottomSheet(
        context: context,
        constraints: const BoxConstraints(),
        builder: (builder) {
          return Container(
            padding: REdgeInsets.all(AppWidgetSize.dimen_12),
            color: Colors.white,
            child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .copyWith(primaryContainer: Colors.white)
                        .primaryContainer,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(AppWidgetSize.dimen_10),
                        topRight: Radius.circular(AppWidgetSize.dimen_10))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CommonTextWidget(
                        textString: titleText,
                        fontWeight: FontWeight.bold,
                        fontSize: AppWidgetSize.dimen_18.sp),
                    Padding(
                      padding: REdgeInsets.only(
                          top: AppWidgetSize.dimen_20, bottom: 20),
                      child: CommonTextWidget(
                          textString: contentText,
                          textColor: const Color(0xFF1f1f1f),
                          fontSize: AppWidgetSize.dimen_16.sp),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding:
                              REdgeInsets.only(left: AppWidgetSize.dimen_20),
                          child: GestureDetector(
                            onTap: buttonOneTap,
                            child: CommonTextWidget(
                                textString: buttonOneText,
                                textColor: Colors.deepPurple,
                                fontWeight: FontWeight.bold,
                                fontSize: AppWidgetSize.dimen_18.sp),
                          ),
                        ),
                        Padding(
                          padding:
                              REdgeInsets.only(left: AppWidgetSize.dimen_20),
                          child: GestureDetector(
                            onTap: buttonTwoTap,
                            child: CommonTextWidget(
                                textString: buttonTwoText,
                                textColor: Colors.deepPurple,
                                fontWeight: FontWeight.bold,
                                fontSize: AppWidgetSize.dimen_18.sp),
                          ),
                        ),
                      ],
                    )
                  ],
                )),
          );
        });
  }

  
}
