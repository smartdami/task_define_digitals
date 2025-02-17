part of 'savings_history_bloc.dart';

sealed class SavingsHistoryState {}

final class SavingsHistoryInitial extends SavingsHistoryState {}

final class SelectedYearState extends SavingsHistoryState {
  final String selectedYear;

  SelectedYearState({required this.selectedYear});
}

final class GenerateStatementState extends SavingsHistoryState {
  final double compACreditAmount;
  final double compADebitAmount;
  final double compBCreditAmount;
  final double compBDebitAmount;

  GenerateStatementState(
      {required this.compACreditAmount,
      required this.compADebitAmount,
      required this.compBCreditAmount,
      required this.compBDebitAmount});
}
