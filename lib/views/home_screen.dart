import 'package:define_digital_tasks/utils/app_contants.dart';
import 'package:define_digital_tasks/utils/app_size.dart';
import 'package:define_digital_tasks/widgets/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../routes/screen_routes.dart';
import '../view_models/home_screen/home_screen_bloc.dart';
import '../widgets/common_card_widgets.dart';

class HomeScreen extends StatefulWidget {
  final String compABal;
  final String compBBal;
  const HomeScreen({super.key, required this.compABal, required this.compBBal});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeScreenBloc _homeScreenBloc;
  late String compABal;
  late String compBBal;
  @override
  void initState() {
    super.initState();
    compABal = widget.compABal;
    compBBal = widget.compBBal;
    _homeScreenBloc = BlocProvider.of<HomeScreenBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenBloc, HomeScreenState>(
      listener: (context, state) {
        if (state is CompanyCardDetailsLoadedState) {
          compABal = state.compABalance;
          compBBal = state.compBBalance;
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Padding(
              padding: REdgeInsets.only(
                  top: AppWidgetSize.dimen_20,
                  left: AppWidgetSize.dimen_15,
                  right: AppWidgetSize.dimen_15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _bankBalanceCards(context, "Comp A", compABal),
                      _bankBalanceCards(context, "Comp B", compBBal),
                    ],
                  ),
                  Padding(
                    padding: REdgeInsets.only(top: AppWidgetSize.dimen_20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buttonWidget(context, "Enter Savings", 0),
                        _buttonWidget(context, "View Savings History", 1),
                      ],
                    ),
                  ),
                  Padding(
                    padding: REdgeInsets.only(top: AppWidgetSize.dimen_20),
                    child: _buttonWidget(context, "Withdraw Amount", 2),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buttonWidget(BuildContext context, String buttonText, int tag) {
    return SizedBox(
      width: tag == 2
          ? AppWidgetSize.screenWidth(context)
          : AppWidgetSize.screenWidth(context) * 0.43,
      height: AppWidgetSize.screenHeight(context) * 0.07,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: tag == 0 ? Colors.white : Colors.deepPurple,
          backgroundColor: tag == 0 ? Colors.deepPurple : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppWidgetSize.dimen_10.r),
          ),
        ),
        onPressed: () async {
          if (tag == 0) {
            await Navigator.pushNamed(context, ScreenRoutes.savingsEntryScreen);
            _homeScreenBloc.add(LoadCompanyCardDetailsEvent());
          } else if (tag == 1) {
            Navigator.pushNamed(context, ScreenRoutes.savingsHistoryScreen);
          } else if (tag == 2) {
            await Navigator.pushNamed(
                context, ScreenRoutes.savingsWithdrawlScreen, arguments: {
              "compABal":compABal,
              "compBBal": compBBal
            });
            _homeScreenBloc.add(LoadCompanyCardDetailsEvent());
          }
        },
        child: CommonTextWidget(
            textString: buttonText,
            fontSize: AppWidgetSize.dimen_16.sp,
            fontWeight: FontWeight.bold,
            topPadding: AppWidgetSize.dimen_5,
            textAlign: TextAlign.center,
            bottomPadding: AppWidgetSize.dimen_5),
      ),
    );
  }

  Widget _bankBalanceCards(
      BuildContext context, String companyName, String balance) {
    return CommonCardWidgets(
        screenWidth: AppWidgetSize.screenWidth(context) * 0.43,
        topleftBorderRadias: AppWidgetSize.dimen_10,
        topRightBorderRadias: AppWidgetSize.dimen_10,
        bottomRightBorderRadias: AppWidgetSize.dimen_10,
        bottomLeftBorderRadias: AppWidgetSize.dimen_10,
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTextWidget(
              textString: companyName,
              leftPadding: AppWidgetSize.dimen_10,
              topPadding: AppWidgetSize.dimen_5,
              fontSize: AppWidgetSize.dimen_14.sp,
            ),
            CommonTextWidget(
              textString: AppConstants.indianRuppee + balance,
              leftPadding: AppWidgetSize.dimen_10,
              rightPadding: AppWidgetSize.dimen_10,
              topPadding: AppWidgetSize.dimen_10,
              bottomPadding: AppWidgetSize.dimen_5,
              fontSize: AppWidgetSize.dimen_16.sp,
              fontWeight: FontWeight.bold,
            )
          ],
        ));
  }
}
