import 'package:equatable/equatable.dart';

class Payment extends Equatable {
  final int? id;
  final String? photo;
  final String? createdAt;

  const Payment({this.id, this.photo, this.createdAt});

  @override
  List<Object?> get props => [id, photo, createdAt];
}
