part of 'withdraw_bloc.dart';

sealed class WithdrawState {}

final class WithdrawInitial extends WithdrawState {}

final class SelectedCompanyState extends WithdrawState {
  final int selectedIndex;

  SelectedCompanyState({required this.selectedIndex});
}

final class WithdrawSuccessState extends WithdrawState {}

final class CommonErrorState extends WithdrawState {
  final String errorMessage;

  CommonErrorState({required this.errorMessage});
}
