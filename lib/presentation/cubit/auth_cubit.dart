import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pilatusapp/domain/entities/user.dart';
import 'package:pilatusapp/domain/usecase/get_token.dart';
import 'package:pilatusapp/domain/usecase/login_auth.dart';
import 'package:pilatusapp/domain/usecase/logout_auth.dart';
import 'package:pilatusapp/domain/usecase/register_auth.dart';
import 'package:pilatusapp/domain/usecase/save_token.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
      {required this.loginAuth,
      required this.registerAuth,
      required this.saveToken,
      required this.getToken,
      required this.logoutAuth})
      : super(UnlogedState());

  final LoginAuth loginAuth;
  final RegisterAuth registerAuth;
  final SaveToken saveToken;
  final GetToken getToken;
  final LogoutAuth logoutAuth;

  void login(User user) async {
    emit(LoadingLoginState());

    final result = await loginAuth.execute(user);

    result.fold((failure) {
      emit(LoginErrorState(failure.message));
    }, (data) async {
      await saveToken.execute(data.accessToken);
      emit(LogedState());
    });
  }

  void register(Map<String, String> data) async {
    emit(LoadingSignUpState());

    final result = await registerAuth.execute(data);

    result.fold((failure) {
      emit(ErrorSignUpState(failure.message));
    }, (data) async {
      await saveToken.execute(data.accessToken);
      emit(LogedState());
    });
  }

  void logout() async {
    final result = await logoutAuth.execute();

    result.fold((failure) {
      emit(LoginErrorState(failure.message));
    }, (data) async {
      emit(UnlogedState());
    });
  }

  void checkLoginState() async {
    final result = await getToken.execute();

    if (result != null) {
      emit(LogedState());
    } else {
      emit(UnlogedState());
    }
  }
}
