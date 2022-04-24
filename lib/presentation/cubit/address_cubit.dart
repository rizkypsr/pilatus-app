import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pilatusapp/domain/entities/address.dart';
import 'package:pilatusapp/domain/usecase/get_address.dart';
import 'package:pilatusapp/domain/usecase/save_address.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit(
      {required this.saveAdressUsecase, required this.getAddressUsecase})
      : super(AddressInitial());

  final SaveAdress saveAdressUsecase;
  final GetAddress getAddressUsecase;

  void getAddress() async {
    final result = await getAddressUsecase.execute();

    result.fold(
        (l) => emit(AddressError(l.message)), (r) => emit(AddressHasData(r)));
  }

  void saveAddress(Address address) async {
    emit(AddressLoading());

    final result = await saveAdressUsecase.execute(address);

    result.fold(
        (l) => emit(AddressError(l.message)), (r) => emit(AddressSaved(r)));

    getAddress();
  }
}
