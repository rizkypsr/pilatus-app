import 'package:equatable/equatable.dart';
import 'package:pilatusapp/domain/entities/address.dart';

// ignore: must_be_immutable
class User extends Equatable {
  User(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.gender,
      this.phone,
      this.address,
      this.photo,
      this.photoUrl});

  int? id;
  String? name;
  String? email;
  String? gender;
  String? phone;
  Address? address;
  String? photo;
  String? photoUrl;
  String? password;

  @override
  List<Object?> get props =>
      [id, name, email, gender, phone, address, photo, photoUrl, password];
}
