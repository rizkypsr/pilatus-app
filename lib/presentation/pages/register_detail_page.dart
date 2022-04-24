import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pilatusapp/presentation/cubit/auth_cubit.dart';
import 'package:pilatusapp/presentation/cubit/city_cubit.dart';
import 'package:pilatusapp/presentation/cubit/province_cubit.dart';
import 'package:pilatusapp/styles/text_styles.dart';
import 'package:pilatusapp/utils/routes.dart';

class RegisterDetail extends StatefulWidget {
  const RegisterDetail({Key? key, required this.data}) : super(key: key);

  final Map<String, String> data;

  @override
  _RegisterDetailState createState() => _RegisterDetailState();
}

class _RegisterDetailState extends State<RegisterDetail> {
  late TextEditingController phoneController;
  late TextEditingController streetController;
  late TextEditingController postalCodeController;
  late TextEditingController districtController;
  final _formKey = GlobalKey<FormState>();

  late List<DropdownMenuItem<String>> provinceMenuItems = [];
  late List<DropdownMenuItem<String>> cityMenuItems = [];
  late String provinceValue, cityValue;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    streetController = TextEditingController();
    postalCodeController = TextEditingController();
    districtController = TextEditingController();

    BlocProvider.of<ProvinceCubit>(context).fetchProvince();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nomor Telp',
                ),
                TextFormField(
                  controller: phoneController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Pastikan data terisi dengan benar';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Masukkan nomor telp',
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: streetController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Alamat',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Pastikan data terisi dengan benar';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.streetAddress,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Provinsi',
                ),
                BlocBuilder<ProvinceCubit, ProvinceState>(
                    builder: (context, state) {
                  if (state is ProvinceLoading) {
                    return const Align(
                        alignment: Alignment.topCenter,
                        child: CircularProgressIndicator());
                  } else if (state is ProvinceHasData) {
                    provinceMenuItems = List.generate(
                      state.province.length,
                      (index) => DropdownMenuItem(
                          child: Text(state.province[index].province!),
                          value: state.province[index].provinceId.toString()),
                    );
                  } else if (state is ProvinceError) {
                    return Align(
                        alignment: Alignment.topCenter,
                        child: Text(state.message));
                  }

                  return DropdownButtonFormField(
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Pastikan data terisi dengan benar';
                      }
                      return null;
                    },
                    value: state is ProvinceOnChanged ? state.id : null,
                    items: provinceMenuItems,
                    onChanged: (String? newValue) {
                      provinceValue = newValue!;
                      BlocProvider.of<ProvinceCubit>(context)
                          .provinceOnChanged(newValue);
                      BlocProvider.of<CityCubit>(context)
                          .fetchCities(int.parse(newValue));
                    },
                  );
                }),
                const SizedBox(height: 20),
                const Text(
                  'Kota',
                ),
                BlocBuilder<CityCubit, CityState>(builder: (context, state) {
                  if (state is CitiesLoading) {
                    return const Align(
                        alignment: Alignment.topCenter,
                        child: CircularProgressIndicator());
                  } else if (state is CitiesHasData) {
                    cityMenuItems = List.generate(
                      state.cities.length,
                      (index) => DropdownMenuItem(
                          child: Text(state.cities[index].cityName!),
                          value: state.cities[index].cityId.toString()),
                    );
                  } else if (state is CitiesError) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
                  }

                  return DropdownButtonFormField(
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Pastikan data terisi dengan benar';
                      } else if (value.length >= 14) {
                        return 'Nomor Telp terlalu panjang';
                      }
                      return null;
                    },
                    value: state is CitiesOnChanged ? state.id : null,
                    items: cityMenuItems,
                    onChanged: (String? newValue) {
                      cityValue = newValue!;
                      BlocProvider.of<CityCubit>(context)
                          .citiesOnChanged(newValue);
                    },
                  );
                }),
                const SizedBox(height: 20),
                const Text(
                  'Kode Pos',
                ),
                TextFormField(
                  controller: postalCodeController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Pastikan data terisi dengan benar';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Masukkan kode pos',
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Kecamatan',
                ),
                TextFormField(
                  controller: districtController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Pastikan data terisi dengan benar';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Masukkan kecamatan',
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                BlocListener<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is LoadingSignUpState) {
                      const Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is LogedState) {
                      Navigator.pushNamed(context, mainPageRoute);
                    }
                  },
                  child: SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Map<String, String> data = {
                            "email": widget.data["email"]!,
                            "password": widget.data["password"]!,
                            "name": widget.data["name"]!,
                            "phone": phoneController.text,
                            "street": streetController.text,
                            "province_id": provinceValue,
                            "city_id": cityValue,
                            "postal_code": postalCodeController.text,
                            "district": districtController.text,
                          };

                          BlocProvider.of<AuthCubit>(context).register(data);
                        }
                      },
                      child: const Text("Daftar"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
