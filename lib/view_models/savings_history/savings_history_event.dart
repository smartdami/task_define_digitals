part of 'savings_history_bloc.dart';

sealed class SavingsHistoryEvent {}

class SelectedYearEvent extends SavingsHistoryEvent {
  final String year;

  SelectedYearEvent({required this.year});
}


class GenerateStatementEvent extends SavingsHistoryEvent {
  final String year;

  GenerateStatementEvent({required this.year});
}
