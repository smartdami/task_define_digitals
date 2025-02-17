import 'package:define_digital_tasks/utils/app_size.dart';
import 'package:define_digital_tasks/view_models/savings_history/savings_history_bloc.dart';
import 'package:define_digital_tasks/views/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_contants.dart';
import '../widgets/common_card_widgets.dart';
import '../widgets/common_text_field_widget.dart';
import '../widgets/common_text_widget.dart';

class SavingsHistoryScreen extends BaseScreen {
  const SavingsHistoryScreen({super.key});

  @override
  State<SavingsHistoryScreen> createState() => _SavingsHistoryScreenState();
}

class _SavingsHistoryScreenState extends BaseScreenState<SavingsHistoryScreen> {
  late SavingsHistoryBloc _savingsHistoryBloc;
  String selectedYear = "";
  List<String> yearsForStatement = ["2025", "2024", "2023", "2022", "2021"];
  @override
  void initState() {
    super.initState();
    _savingsHistoryBloc = BlocProvider.of<SavingsHistoryBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SavingsHistoryBloc, SavingsHistoryState>(
        listener: (context, state) {
      if (state is SelectedYearState) {
        selectedYear = state.selectedYear;
      }
    }, builder: (context, state) {
      return SafeArea(
          child: Scaffold(
              body: Padding(
                  padding: REdgeInsets.only(
                      top: AppWidgetSize.dimen_20,
                      left: AppWidgetSize.dimen_15,
                      right: AppWidgetSize.dimen_15),
                  child: Column(children: [
                    _yearLabel(),
                    _selectYearTextField(context),
                    _generateReportWidget(context),
                    if (state is GenerateStatementState) ...[
                      _bankBalanceCards(
                          context,
                          "Comp A",
                          state.compACreditAmount.toString(),
                          state.compADebitAmount.toString(),
                          (state.compACreditAmount - state.compADebitAmount)
                              .toString()),
                      _bankBalanceCards(
                          context,
                          "Comp B",
                          state.compBCreditAmount.toString(),
                          state.compBDebitAmount.toString(),
                          (state.compBCreditAmount - state.compBDebitAmount)
                              .toString()),
                    ]
                  ]))));
    });
  }

  Widget _generateReportWidget(BuildContext context) {
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
                    borderRadius:
                        BorderRadius.circular(AppWidgetSize.dimen_10.r),
                  ),
                ),
                onPressed: () {
                  if (selectedYear.isNotEmpty) {
                    _savingsHistoryBloc
                        .add(GenerateStatementEvent(year: selectedYear));
                  } else {
                    showErrorMessage("Please Select Year");
                  }
                },
                child: CommonTextWidget(
                    textString: "Generate Report",
                    fontSize: AppWidgetSize.dimen_16.sp,
                    fontWeight: FontWeight.bold,
                    topPadding: AppWidgetSize.dimen_5,
                    textAlign: TextAlign.center,
                    bottomPadding: AppWidgetSize.dimen_5))));
  }

  Widget _selectYearTextField(BuildContext context) {
    return CommonTextFieldWidget(
      hintText: selectedYear.isEmpty ? 'Select Year' : selectedYear,
      isReadOnly: true,
      onTap: () => _yearBottomSheet(context),
    );
  }

  Widget _yearLabel() {
    return Align(
      alignment: Alignment.topLeft,
      child: CommonTextWidget(
          textString: "Year",
          fontSize: AppWidgetSize.dimen_16.sp,
          fontWeight: FontWeight.bold,
          leftPadding: AppWidgetSize.dimen_8,
          rightPadding: AppWidgetSize.dimen_8,
          topPadding: AppWidgetSize.dimen_5,
          textAlign: TextAlign.start,
          bottomPadding: AppWidgetSize.dimen_15),
    );
  }

  Widget _bankBalanceCards(BuildContext context, String companyName,
      String savingsAmount, String withdrawAmount, String availableBalance) {
    return Padding(
      padding: REdgeInsets.only(top: AppWidgetSize.dimen_20),
      child: CommonCardWidgets(
          cardColor: Colors.white,
          screenWidth: AppWidgetSize.screenWidth(context),
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
                fontSize: AppWidgetSize.dimen_16.sp,
                fontWeight: FontWeight.bold,
              ),
              CommonTextWidget(
                textString:
                    "Total Savings Amount : ${AppConstants.indianRuppee}$savingsAmount",
                leftPadding: AppWidgetSize.dimen_10,
                rightPadding: AppWidgetSize.dimen_10,
                topPadding: AppWidgetSize.dimen_10,
                bottomPadding: AppWidgetSize.dimen_5,
                fontSize: AppWidgetSize.dimen_16.sp,
                textColor: Colors.green,
                fontWeight: FontWeight.bold,
              ),
              CommonTextWidget(
                textString:
                    "Total Withdraw Amount : ${AppConstants.indianRuppee}$withdrawAmount",
                leftPadding: AppWidgetSize.dimen_10,
                rightPadding: AppWidgetSize.dimen_10,
                topPadding: AppWidgetSize.dimen_10,
                bottomPadding: AppWidgetSize.dimen_5,
                fontSize: AppWidgetSize.dimen_16.sp,
                textColor: Colors.red,
                fontWeight: FontWeight.bold,
              ),
              CommonTextWidget(
                textString:
                    "Available Amount : ${AppConstants.indianRuppee}$availableBalance",
                leftPadding: AppWidgetSize.dimen_10,
                rightPadding: AppWidgetSize.dimen_10,
                topPadding: AppWidgetSize.dimen_10,
                bottomPadding: AppWidgetSize.dimen_5,
                fontSize: AppWidgetSize.dimen_16.sp,
                fontWeight: FontWeight.bold,
              )
            ],
          )),
    );
  }

  _yearBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        constraints:
            BoxConstraints(minWidth: AppWidgetSize.screenWidth(context)),
        builder: (builder) {
          return PopScope(
              canPop: true,
              child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: DraggableScrollableSheet(
                      initialChildSize: 0.35,
                      minChildSize: 0.35,
                      maxChildSize: 0.7,
                      builder: (context, controller) {
                        return Container(
                            padding: REdgeInsets.only(
                                top: AppWidgetSize.dimen_10,
                                left: AppWidgetSize.dimen_12,
                                right: AppWidgetSize.dimen_12),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft:
                                        Radius.circular(AppWidgetSize.dimen_25),
                                    topRight: Radius.circular(
                                        AppWidgetSize.dimen_25))),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  CommonTextWidget(
                                    textString: "Select Year",
                                    fontSize: AppWidgetSize.dimen_14.sp,
                                    fontWeight: FontWeight.bold,
                                    textColor: const Color(0xFF1f1f1f),
                                    topPadding: AppWidgetSize.dimen_30,
                                    bottomPadding: AppWidgetSize.dimen_20,
                                  ),
                                  ...yearsForStatement.map((e) =>
                                      GestureDetector(
                                        onTap: () {
                                          _savingsHistoryBloc
                                              .add(SelectedYearEvent(year: e));
                                          Navigator.of(context).pop();
                                        },
                                        child: CommonTextWidget(
                                          textString: e,
                                          fontSize: AppWidgetSize.dimen_12.sp,
                                          fontWeight: FontWeight.bold,
                                          textColor: const Color(0xFF1f1f1f),
                                          topPadding: AppWidgetSize.dimen_10,
                                          bottomPadding: AppWidgetSize.dimen_10,
                                        ),
                                      ))
                                ]));
                      })));
        });
  }
}
