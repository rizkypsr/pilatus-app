import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pilatusapp/domain/entities/address.dart';
import 'package:pilatusapp/domain/entities/city.dart';
import 'package:pilatusapp/domain/entities/province.dart';
import 'package:pilatusapp/presentation/cubit/address_cubit.dart';
import 'package:pilatusapp/presentation/cubit/city_cubit.dart';
import 'package:pilatusapp/presentation/cubit/province_cubit.dart';
import 'package:pilatusapp/styles/colors.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  late List<DropdownMenuItem<String>> provinceMenuItems = [];
  late List<DropdownMenuItem<String>> cityMenuItems = [];

  final _formKey = GlobalKey<FormState>();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController streetController = TextEditingController();

  late String provinceValue, cityValue;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProvinceCubit>(context).fetchProvince();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Alamat'),
        actions: [
          BlocListener<AddressCubit, AddressState>(
            listener: (context, state) {
              if (state is AddressSaved) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
                Navigator.pop(context);
              } else if (state is AddressError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            child: TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final address = Address(
                        street: streetController.text,
                        province:
                            Province(provinceId: int.parse(provinceValue)),
                        city: City(cityId: int.parse(cityValue)),
                        district: districtController.text,
                        postalCode: postalCodeController.text);

                    BlocProvider.of<AddressCubit>(context).saveAddress(address);
                  }
                },
                child: const Text(
                  'SIMPAN',
                  style: TextStyle(color: kLightOnPrimary),
                )),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pilih Alamat',
                style: TextStyle(fontWeight: FontWeight.bold),
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
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
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
              const SizedBox(
                height: 15,
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
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: districtController,
                decoration: const InputDecoration(
                  labelText: 'Kecamatan',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pastikan data terisi dengan benar';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: postalCodeController,
                decoration: const InputDecoration(
                  labelText: 'Kode Pos',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pastikan data terisi dengan benar';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: streetController,
                maxLines: 5,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
