import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pilatusapp/domain/entities/user.dart';
import 'package:pilatusapp/domain/usecase/get_user.dart';
import 'package:pilatusapp/domain/usecase/update_user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit({required this.updateUser, required this.getUser})
      : super(UserInitial());

  final UpdateUser updateUser;
  final GetUser getUser;

  void getUserProfile() async {
    emit(UserLoading());

    final result = await getUser.execute();

    result.fold((l) => emit(UserError(l.message)), (r) => emit(UserHasData(r)));
  }

  void updateUserProfile(User user) async {
    emit(UserLoading());

    final result = await updateUser.execute(user);

    result.fold((l) => emit(UserError(l.message)), (r) => emit(UserUpdated(r)));

    getUserProfile();
  }
}
