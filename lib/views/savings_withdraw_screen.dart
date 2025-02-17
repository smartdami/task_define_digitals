import 'package:define_digital_tasks/utils/app_contants.dart';
import 'package:define_digital_tasks/utils/app_size.dart';
import 'package:define_digital_tasks/view_models/withdraw/withdraw_bloc.dart';
import 'package:define_digital_tasks/views/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/common_text_field_widget.dart';
import '../widgets/common_text_widget.dart';

class SavingsWithdrawScreen extends BaseScreen {
  final String compABal;
  final String compBBal;
  const SavingsWithdrawScreen({
    super.key,
    required this.compABal,
    required this.compBBal,
  });

  @override
  State<SavingsWithdrawScreen> createState() => _SavingsWithdrawScreenState();
}

class _SavingsWithdrawScreenState
    extends BaseScreenState<SavingsWithdrawScreen> {
  List<String> companyName = ["Company A", "Company B"];
  double compAbalance = 0;
  double compBbalance = 0;
  late WithdrawBloc _withdrawBloc;
  String selectedCompany = "";
  final TextEditingController _amountController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _withdrawBloc = BlocProvider.of<WithdrawBloc>(context);
    compAbalance = double.parse(widget.compABal);
    compBbalance = double.parse(widget.compBBal);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WithdrawBloc, WithdrawState>(
      listener: (context, state) async {
        if (state is SelectedCompanyState) {
          selectedCompany = companyName[state.selectedIndex];
        } else if (state is WithdrawSuccessState) {
          Navigator.of(context).pop();
          await Future.delayed(const Duration(seconds: 1));
          Navigator.of(context).pop();
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
                    child: Column(children: [
                      _companyNameLabel(),
                      _selectCompanytextField(context),
                      _withdrawAmtLabelWidget(),
                      _amountTextField(),
                      _withdrawBtnWidget(context)
                    ]))));
      },
    );
  }

  Widget _withdrawBtnWidget(BuildContext context) {
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
                if (selectedCompany.isEmpty) {
                  showErrorMessage("Please Select Company");
                } else if (_amountController.text.isEmpty ||
                    double.parse(_amountController.text) <= 0) {
                  showErrorMessage("Please Enter Valid Amount",
                      isErrorUI: true);
                } else if (selectedCompany == "Company A" &&
                    (double.parse(_amountController.text) > compAbalance)) {
                  showErrorMessage(
                      "Please Enter Amount Below ${AppConstants.indianRuppee} $compAbalance",
                      isErrorUI: true);
                } else if (selectedCompany == "Company B" &&
                    (double.parse(_amountController.text) > compBbalance)) {
                  showErrorMessage(
                      "Please Enter Amount Below ${AppConstants.indianRuppee} $compBbalance",
                      isErrorUI: true);
                } else {
                  showAlertBottomSheet(
                    titleText: "Confirm",
                    contentText:
                        "Are you sure to withdraw ${AppConstants.indianRuppee}${_amountController.text} from $selectedCompany",
                    buttonOneText: "Cancel",
                    buttonTwoText: "Withdraw",
                    buttonOneTap: () => Navigator.of(context).pop(),
                    buttonTwoTap: () => _withdrawBloc.add(WithdrawAmountEvent(
                        selectedAmount: _amountController.text)),
                  );
                }
              },
              child: CommonTextWidget(
                  textString: "Withdraw",
                  fontSize: AppWidgetSize.dimen_16.sp,
                  fontWeight: FontWeight.bold,
                  topPadding: AppWidgetSize.dimen_5,
                  textAlign: TextAlign.center,
                  bottomPadding: AppWidgetSize.dimen_5),
            )));
  }

  Widget _amountTextField() {
    return CommonTextFieldWidget(
      hintText: 'Enter Amount',
      textEditingController: _amountController,
    );
  }

  Widget _withdrawAmtLabelWidget() {
    return Align(
      alignment: Alignment.topLeft,
      child: CommonTextWidget(
          textString: "Withdraw Amount",
          fontSize: AppWidgetSize.dimen_16.sp,
          fontWeight: FontWeight.bold,
          leftPadding: AppWidgetSize.dimen_8,
          rightPadding: AppWidgetSize.dimen_8,
          topPadding: AppWidgetSize.dimen_25,
          textAlign: TextAlign.start,
          bottomPadding: AppWidgetSize.dimen_15),
    );
  }

  Widget _selectCompanytextField(BuildContext context) {
    return CommonTextFieldWidget(
      hintText: selectedCompany.isEmpty ? 'Select Company' : selectedCompany,
      isReadOnly: true,
      onTap: () => _companyNameBottomSheet(
        context,
      ),
    );
  }

  Widget _companyNameLabel() {
    return Align(
      alignment: Alignment.topLeft,
      child: CommonTextWidget(
          textString: "Company Name",
          fontSize: AppWidgetSize.dimen_16.sp,
          fontWeight: FontWeight.bold,
          leftPadding: AppWidgetSize.dimen_8,
          rightPadding: AppWidgetSize.dimen_8,
          topPadding: AppWidgetSize.dimen_5,
          textAlign: TextAlign.start,
          bottomPadding: AppWidgetSize.dimen_15),
    );
  }

  _companyNameBottomSheet(BuildContext context) {
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
                                    textString: "Select Company Name",
                                    fontSize: AppWidgetSize.dimen_14.sp,
                                    fontWeight: FontWeight.bold,
                                    textColor: const Color(0xFF1f1f1f),
                                    topPadding: AppWidgetSize.dimen_30,
                                    bottomPadding: AppWidgetSize.dimen_20,
                                  ),
                                  ...companyName.map((e) => GestureDetector(
                                        onTap: () {
                                          _withdrawBloc.add(
                                              SelectedCompanyEvent(
                                                  index:
                                                      companyName.indexOf(e)));
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
