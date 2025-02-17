part of 'withdraw_bloc.dart';

sealed class WithdrawEvent {}

final class SelectedCompanyEvent extends WithdrawEvent {
  final int index;

  SelectedCompanyEvent({required this.index});
}

final class WithdrawAmountEvent extends WithdrawEvent {
  final String selectedAmount;

  WithdrawAmountEvent({required this.selectedAmount});
}
