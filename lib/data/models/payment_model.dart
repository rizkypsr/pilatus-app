import 'package:equatable/equatable.dart';
import 'package:pilatusapp/domain/entities/payment.dart';

class PaymentModel extends Equatable {
  const PaymentModel({this.id, this.photo, this.createdAt});

  final int? id;
  final String? photo;
  final String? createdAt;

  factory PaymentModel.fromJson(Map<String, dynamic>? json) => PaymentModel(
      id: json != null ? json["id"] : null,
      photo: json != null ? json["photo"] : null,
      createdAt: json != null ? json["created_at"] : null);

  Map<String, dynamic> toJson() =>
      {"id": id, "photo": photo, "created_at": createdAt};

  Payment toEntity() {
    return Payment(id: id, photo: photo, createdAt: createdAt);
  }

  @override
  List<Object?> get props => [id, photo];
}
