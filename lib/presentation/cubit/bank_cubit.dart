import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pilatusapp/domain/entities/bank.dart';
import 'package:pilatusapp/domain/usecase/get_bank.dart';

part 'bank_state.dart';

class BankCubit extends Cubit<BankState> {
  BankCubit({required this.getBank}) : super(BankInitial());

  final GetBank getBank;

  void getBankAccount() async {
    final result = await getBank.execute();

    result.fold((l) => null, (r) => emit(BankHasData(r)));
  }
}
