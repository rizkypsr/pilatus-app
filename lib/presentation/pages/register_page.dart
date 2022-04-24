import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pilatusapp/domain/entities/user.dart';
import 'package:pilatusapp/presentation/cubit/auth_cubit.dart';
import 'package:pilatusapp/styles/text_styles.dart';
import 'package:pilatusapp/utils/routes.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController nameController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Align(
          alignment: const AlignmentDirectional(0, 0),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Daftar',
                    style: kHeading5,
                  ),
                  const Divider(),
                  const Text(
                    'Email',
                  ),
                  TextFormField(
                    controller: emailController,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Pastikan data terisi dengan benar';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Masukkan email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Password',
                  ),
                  TextFormField(
                    controller: passwordController,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Pastikan data terisi dengan benar';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Masukkan password',
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Nama',
                  ),
                  TextFormField(
                    controller: nameController,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Pastikan data terisi dengan benar';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Masukkan nama',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final data = {
                            "email": emailController.text,
                            "password": passwordController.text,
                            "name": nameController.text
                          };

                          Navigator.pushNamed(context, registerDetailPageRoute,
                              arguments: data);
                        }
                      },
                      child: const Text("Lanjut"),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Sudah punya akun?',
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Masuk'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
