import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pilatusapp/domain/entities/category.dart';
import 'package:pilatusapp/domain/usecase/get_categories.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit({required this.getCategories}) : super(CategoryInitial());

  final GetCategories getCategories;

  void fetchCategories() async {
    emit(CategoryLoading());
    final results = await getCategories.execute();

    results.fold((failure) async {
      emit(CategoryError(failure.message));
    }, (data) {
      emit(CategoryHasData(data));
    });
  }
}
