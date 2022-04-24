import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pilatusapp/presentation/cubit/auth_cubit.dart';
import 'package:pilatusapp/utils/routes.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key? key}) : super(key: key);

  final List<String> _items = ['Detail Personal'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Akun Saya'),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<AuthCubit>(context).logout();
            },
            icon: const Icon(Icons.logout_rounded),
          )
        ],
      ),
      body: SizedBox(
        height: 100,
        child: ListView(
          children: ListTile.divideTiles(
              color: Colors.grey,
              tiles: _items.map((item) => InkWell(
                    onTap: () {
                      if (item == 'Detail Personal') {
                        Navigator.pushNamed(context, personalDetailsPageRoute);
                      }
                    },
                    child: ListTile(
                      title: Text(item),
                    ),
                  ))).toList(),
        ),
      ),
    );
  }
}
