import 'package:equatable/equatable.dart';
import 'package:pilatusapp/domain/entities/user.dart';

class UserModel extends Equatable {
  const UserModel({required this.id, required this.name, required this.email});

  final int id;
  final String name;
  final String email;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json['name'],
        email: json['email'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
      };

  User toEntity() {
    return User(id: id, name: name, email: email);
  }

  @override
  List<Object?> get props => [id, name, email];
}
