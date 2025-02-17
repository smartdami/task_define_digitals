import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/db_helper.dart';

part 'savings_history_event.dart';
part 'savings_history_state.dart';

class SavingsHistoryBloc
    extends Bloc<SavingsHistoryEvent, SavingsHistoryState> {
  SavingsHistoryBloc() : super(SavingsHistoryInitial()) {
    on<SavingsHistoryEvent>((event, emit) async {
      if (event is SelectedYearEvent) {
        emit(SelectedYearState(selectedYear: event.year));
      } else if (event is GenerateStatementEvent) {
        await _savingsHistoryEvent(event, emit);
      }
    });
  }

  Future<void> _savingsHistoryEvent(
      GenerateStatementEvent event, Emitter<SavingsHistoryState> emit) async {
    List<Map<String, dynamic>> compACreditRows = [];
    List<Map<String, dynamic>> compADebitRows = [];
    List<Map<String, dynamic>> compBCreditRows = [];
    List<Map<String, dynamic>> compBDebitRows = [];
    List<dynamic> results = await Future.wait([
      DatabaseHelper()
          .getSavingHistoryByCompanyName("compA", "credit", year: event.year),
      DatabaseHelper()
          .getSavingHistoryByCompanyName("compA", "debit", year: event.year),
      DatabaseHelper()
          .getSavingHistoryByCompanyName("compB", "credit", year: event.year),
      DatabaseHelper()
          .getSavingHistoryByCompanyName("compB", "debit", year: event.year)
    ]);
    compACreditRows = results[0] as List<Map<String, dynamic>>;
    compADebitRows = results[1] as List<Map<String, dynamic>>;
    compBCreditRows = results[2] as List<Map<String, dynamic>>;
    compBDebitRows = results[3] as List<Map<String, dynamic>>;
    double compACreditAmount = 0;
    double compADebitAmount = 0;
    double compBCreditAmount = 0;
    double compBDebitAmount = 0;
    for (var row in compACreditRows) {
      double amount = row['amount']?.toDouble() ?? 0.0;
      compACreditAmount += amount;
    }
    for (var row in compADebitRows) {
      double amount = row['amount']?.toDouble() ?? 0.0;
      compADebitAmount += amount;
    }
    for (var row in compBCreditRows) {
      double amount = row['amount']?.toDouble() ?? 0.0;
      compBCreditAmount += amount;
    }
    for (var row in compBDebitRows) {
      double amount = row['amount']?.toDouble() ?? 0.0;
      compBDebitAmount += amount;
    }

    emit(GenerateStatementState(
        compACreditAmount: compACreditAmount,
        compADebitAmount: compADebitAmount,
        compBCreditAmount: compBCreditAmount,
        compBDebitAmount: compBDebitAmount));
  }
}
