import 'package:equatable/equatable.dart';
import 'package:pilatusapp/data/models/auth_model.dart';
import 'package:pilatusapp/data/models/category_model.dart';

class AuthResponse extends Equatable {
  final AuthModel auth;

  const AuthResponse({required this.auth});

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      AuthResponse(auth: AuthModel.fromJson(json['data']));

  @override
  List<Object?> get props => [auth];
}
