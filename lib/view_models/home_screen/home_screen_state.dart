part of 'home_screen_bloc.dart';

sealed class HomeScreenState {}

final class HomeScreenInitial extends HomeScreenState {}

final class CompanyCardDetailsLoadedState extends HomeScreenState {
  final String compABalance ;
  final String compBBalance ;

  CompanyCardDetailsLoadedState({required this.compABalance, required this.compBBalance});
}

final class CommonErrorState extends HomeScreenState {
  final String errorMessage;

  CommonErrorState({required this.errorMessage});
}

final class SavingsDetailsSuccessState extends HomeScreenState {
  final String successMessage;

  SavingsDetailsSuccessState({required this.successMessage});
}