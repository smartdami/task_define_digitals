import 'package:define_digital_tasks/utils/db_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'withdraw_event.dart';
part 'withdraw_state.dart';

class WithdrawBloc extends Bloc<WithdrawEvent, WithdrawState> {
  String selectedComp = "";
  WithdrawBloc() : super(WithdrawInitial()) {
    on<WithdrawEvent>((event, emit) async {
      if (event is SelectedCompanyEvent) {
        _selectedCompanyEvent(event, emit);
      } else if (event is WithdrawAmountEvent) {
        await _withdrawAmountEvent(event, emit);
      }
    });
  }

  Future<void> _withdrawAmountEvent(
      WithdrawAmountEvent event, Emitter<WithdrawState> emit) async {
    double selectedAmount = double.parse(event.selectedAmount);
    await DatabaseHelper().insertSavingHistory({
      "company_name": selectedComp,
      "description": "debit",
      "amount": selectedAmount,
      "transaction_date": DateTime.now().toIso8601String()
    });

    emit(WithdrawSuccessState());
  }

  void _selectedCompanyEvent(SelectedCompanyEvent event, emit) {
    if (event.index == 0) {
      selectedComp = "compA";
    } else {
      selectedComp = "compB";
    }
    emit(SelectedCompanyState(selectedIndex: event.index));
  }
}
