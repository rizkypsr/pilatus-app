import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pilatusapp/common/enums.dart';
import 'package:pilatusapp/presentation/cubit/user_cubit.dart';
import 'package:pilatusapp/styles/colors.dart';
import 'package:pilatusapp/styles/text_styles.dart';
import 'package:pilatusapp/utils/routes.dart';

class PersonalDetailsPage extends StatefulWidget {
  const PersonalDetailsPage({Key? key}) : super(key: key);

  @override
  State<PersonalDetailsPage> createState() => _PersonalDetailsPageState();
}

class _PersonalDetailsPageState extends State<PersonalDetailsPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserCubit>(context).getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Detail Personal"),
        ),
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is UserError) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is UserHasData) {
              return ListView(
                children: ListTile.divideTiles(color: Colors.grey, tiles: [
                  BuildListTile(
                    title: "Nama Lengkap",
                    subtitle: state.user.name!,
                    onTap: () {
                      Navigator.pushNamed(context, personalEditPageRoute,
                          arguments: {
                            'value': state.user,
                            'type': EditFields.name
                          });
                    },
                  ),
                  BuildListTile(
                    title: "Alamat Email",
                    subtitle: state.user.email!,
                    onTap: () {
                      Navigator.pushNamed(context, personalEditPageRoute,
                          arguments: {
                            'value': state.user,
                            'type': EditFields.email
                          });
                    },
                  ),
                ]).toList(),
              );
            } else {
              return Container();
            }
          },
        ));
  }
}

// ignore: must_be_immutable
class BuildListTile extends StatelessWidget {
  BuildListTile(
      {Key? key, required this.title, required this.subtitle, this.onTap})
      : super(key: key);

  final String title;
  final String subtitle;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(
        subtitle,
        style: kSubtitle,
      ),
      trailing: const Text(
        "UBAH",
        style: TextStyle(color: kLightPrimary, fontWeight: FontWeight.bold),
      ),
    );
  }
}
