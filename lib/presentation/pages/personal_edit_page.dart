import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pilatusapp/common/enums.dart';
import 'package:pilatusapp/domain/entities/user.dart';
import 'package:pilatusapp/presentation/cubit/user_cubit.dart';

class PersonalEditPage extends StatefulWidget {
  PersonalEditPage({
    Key? key,
    required this.type,
    required this.user,
  }) : super(key: key);

  final User user;
  final EditFields type;

  @override
  State<PersonalEditPage> createState() => _PersonalEditPageState();
}

class _PersonalEditPageState extends State<PersonalEditPage> {
  late final TextEditingController editingController;

  @override
  void initState() {
    super.initState();
    editingController = TextEditingController(
        text: widget.type == EditFields.email
            ? widget.user.email
            : widget.user.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Ubah ${widget.type == EditFields.name ? 'Nama Lengkap' : 'Alamat Email'}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: editingController,
            ),
            const SizedBox(height: 16),
            BlocConsumer<UserCubit, UserState>(
              listener: (context, state) {
                if (state is UserUpdated) {
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                if (state is UserLoading) {
                  return const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(
                          onPressed: () {
                            if (widget.type == EditFields.name) {
                              final data = User(
                                  name: editingController.text,
                                  email: widget.user.email);
                              BlocProvider.of<UserCubit>(context)
                                  .updateUserProfile(data);
                            } else {
                              final data = User(
                                  name: widget.user.name,
                                  email: editingController.text);
                              BlocProvider.of<UserCubit>(context)
                                  .updateUserProfile(data);
                            }
                          },
                          child: const Text('UBAH')));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
