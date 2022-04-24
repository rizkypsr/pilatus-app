import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pilatusapp/domain/entities/category.dart';
import 'package:pilatusapp/presentation/cubit/category_cubit.dart';
import 'package:pilatusapp/utils/dummy.dart';
import 'package:pilatusapp/utils/routes.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoryCubit>(context).fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
            color: const Color(0xfffafafa),
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: BlocBuilder<CategoryCubit, CategoryState>(
              builder: (context, state) {
                if (state is CategoryLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is CategoryError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else if (state is CategoryHasData) {
                  return ListView.builder(
                      itemCount: state.results.length,
                      itemBuilder: (context, index) =>
                          CategoryListItem(category: state.results[index]));
                } else {
                  return const Center(
                    child: Text('Tidak Ada Kategori'),
                  );
                }
              },
            )));
  }
}

PreferredSizeWidget _buildAppBar(context) {
  return AppBar(
    title: const Text('Kategori'),
  );
}

class CategoryListItem extends StatelessWidget {
  const CategoryListItem({Key? key, required this.category}) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      margin: const EdgeInsets.only(bottom: 5),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, detailCategoryPageRoute,
              arguments: category.id);
        },
        child: Row(
          children: [
            const Icon(
              Icons.ac_unit,
              size: 40,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              category.name,
              style: Theme.of(context).textTheme.subtitle1,
            )
          ],
        ),
      ),
    );
  }
}
