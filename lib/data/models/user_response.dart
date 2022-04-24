import 'package:equatable/equatable.dart';
import 'package:pilatusapp/data/models/user_model.dart';

class UserResponse extends Equatable {
  final UserModel user;

  const UserResponse({required this.user});

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        user: UserModel.fromJson(json['data']),
      );

  @override
  List<Object?> get props => [user];
}
