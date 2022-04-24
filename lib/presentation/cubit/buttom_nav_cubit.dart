import 'package:bloc/bloc.dart';

class ButtomNavCubit extends Cubit<int> {
  ButtomNavCubit() : super(0);

  void getHomePage() => emit(0);
  void getCategoryPage() => emit(1);
  void getOrderPage() => emit(2);
  void getAccountPage() => emit(3);
}
