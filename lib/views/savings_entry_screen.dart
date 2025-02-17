import 'package:define_digital_tasks/utils/app_size.dart';
import 'package:define_digital_tasks/views/base_screen.dart';
import 'package:define_digital_tasks/widgets/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../view_models/home_screen/home_screen_bloc.dart';
import '../widgets/common_text_field_widget.dart';

class SavingsEntryScreen extends BaseScreen {
  const SavingsEntryScreen({super.key});

  @override
  State<SavingsEntryScreen> createState() => _SavingsEntryScreenState();
}

class _SavingsEntryScreenState extends BaseScreenState<SavingsEntryScreen> {
  late HomeScreenBloc _homeScreenBloc;
  final TextEditingController savingsEntryController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _homeScreenBloc = BlocProvider.of<HomeScreenBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeScreenBloc, HomeScreenState>(
      listener: (context, state) {
        if (state is SavingsDetailsSuccessState) {
          Navigator.of(context).pop();
        }
      },
      child: SafeArea(
          child: Scaffold(
              body: Padding(
                  padding: REdgeInsets.only(
                      top: AppWidgetSize.dimen_20,
                      left: AppWidgetSize.dimen_15,
                      right: AppWidgetSize.dimen_15),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _annualSavingsLabel(),
                        _amountTextField(),
                        _depositBtnWidget(context)
                      ])))),
    );
  }

  Widget _depositBtnWidget(BuildContext context) {
    return Padding(
      padding: REdgeInsets.only(top: AppWidgetSize.dimen_20),
      child: SizedBox(
          width: AppWidgetSize.screenWidth(context) * 0.43,
          height: AppWidgetSize.screenHeight(context) * 0.07,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.deepPurple,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppWidgetSize.dimen_10.r),
              ),
            ),
            onPressed: () {
              if (savingsEntryController.text.isEmpty ||
                  double.parse(savingsEntryController.text) <= 0) {
                showErrorMessage("Please Enter Valid Amount", isErrorUI: true);
              } else {
                _homeScreenBloc.add(EnterSavingsDetailsEvent(
                    savingsAmount: savingsEntryController.text));
              }
            },
            child: CommonTextWidget(
                textString: "Deposit",
                fontSize: AppWidgetSize.dimen_16.sp,
                fontWeight: FontWeight.bold,
                topPadding: AppWidgetSize.dimen_5,
                textAlign: TextAlign.center,
                bottomPadding: AppWidgetSize.dimen_5),
          )),
    );
  }

  Widget _amountTextField() {
    return CommonTextFieldWidget(
      hintText: 'Enter Amount',
      textEditingController: savingsEntryController,
    );
  }

  Widget _annualSavingsLabel() {
    return Align(
      alignment: Alignment.topLeft,
      child: CommonTextWidget(
          textString: "Enter Annual Savings",
          fontSize: AppWidgetSize.dimen_16.sp,
          fontWeight: FontWeight.bold,
          leftPadding: AppWidgetSize.dimen_8,
          rightPadding: AppWidgetSize.dimen_8,
          topPadding: AppWidgetSize.dimen_5,
          textAlign: TextAlign.start,
          bottomPadding: AppWidgetSize.dimen_15),
    );
  }
}
