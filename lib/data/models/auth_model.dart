import 'package:equatable/equatable.dart';
import 'package:pilatusapp/domain/entities/auth.dart';

class AuthModel extends Equatable {
  const AuthModel({required this.accessToken});

  final String accessToken;

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
      };

  Auth toEntity() {
    return Auth(
      accessToken: accessToken,
    );
  }

  @override
  List<Object?> get props => [accessToken];
}
