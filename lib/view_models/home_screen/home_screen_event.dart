part of 'home_screen_bloc.dart';

sealed class HomeScreenEvent {}

class LoadCompanyCardDetailsEvent extends HomeScreenEvent {}

class EnterSavingsDetailsEvent extends HomeScreenEvent {
  final String savingsAmount;

  EnterSavingsDetailsEvent({required this.savingsAmount});
}
