import 'package:equatable/equatable.dart';

class Auth extends Equatable {
  Auth({required this.accessToken});

  final String accessToken;
  @override
  List<Object?> get props => [accessToken];
}
