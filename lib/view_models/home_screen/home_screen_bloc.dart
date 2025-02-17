import 'package:define_digital_tasks/utils/db_helper.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenInitial()) {
    on<HomeScreenEvent>((event, emit) async {
      if (event is LoadCompanyCardDetailsEvent) {
        await _loadCompanyCardDetailsEvent(emit);
      } else if (event is EnterSavingsDetailsEvent) {
        await _savingsDetailsEvent(event, emit);
      }
    });
  }

  Future<void> _savingsDetailsEvent(
      EnterSavingsDetailsEvent event, Emitter<HomeScreenState> emit) async {
    final double savingsAmount = double.parse(event.savingsAmount);
    final double eachCompanyShare = savingsAmount / 2;
    List<dynamic> results = await Future.wait([
      DatabaseHelper().insertSavingHistory({
        "company_name": "compA",
        "description": "credit",
        "amount": eachCompanyShare,
        "transaction_date": DateTime.now().toIso8601String()
      }),
      DatabaseHelper().insertSavingHistory({
        "company_name": "compB",
        "description": "credit",
        "amount": eachCompanyShare.toString(),
        "transaction_date": DateTime.now().toIso8601String()
      }),
    ]);
    if (results.isNotEmpty) {
      emit(SavingsDetailsSuccessState(
          successMessage: "Amount added in savings account"));
    }
  }

  Future<void> _loadCompanyCardDetailsEvent(
      Emitter<HomeScreenState> emit) async {
    List<Map<String, dynamic>> compACreditRows = [];
    List<Map<String, dynamic>> compADebitRows = [];
    List<Map<String, dynamic>> compBCreditRows = [];
    List<Map<String, dynamic>> compBDebitRows = [];
    List<dynamic> results = await Future.wait([
      DatabaseHelper().getSavingHistoryByCompanyName("compA", "credit"),
      DatabaseHelper().getSavingHistoryByCompanyName("compA", "debit"),
      DatabaseHelper().getSavingHistoryByCompanyName("compB", "credit"),
      DatabaseHelper().getSavingHistoryByCompanyName("compB", "debit")
    ]);
    compACreditRows = results[0] as List<Map<String, dynamic>>;
    compADebitRows = results[1] as List<Map<String, dynamic>>;
    compBCreditRows = results[2] as List<Map<String, dynamic>>;
    compBDebitRows = results[3] as List<Map<String, dynamic>>;
    double compATotalAmount = 0;
    double compBTotalAmount = 0;
    for (var row in compACreditRows) {
      double amount = row['amount']?.toDouble() ?? 0.0;
      compATotalAmount += amount;
    }
    for (var row in compADebitRows) {
      double amount = row['amount']?.toDouble() ?? 0.0;
      compATotalAmount -= amount;
    }
    for (var row in compBCreditRows) {
      double amount = row['amount']?.toDouble() ?? 0.0;
      compBTotalAmount += amount;
    }
    for (var row in compBDebitRows) {
      double amount = row['amount']?.toDouble() ?? 0.0;
      compBTotalAmount -= amount;
    }

    emit(CompanyCardDetailsLoadedState(
        compABalance: compATotalAmount.toString(),
        compBBalance: compBTotalAmount.toString()));
  }
}
