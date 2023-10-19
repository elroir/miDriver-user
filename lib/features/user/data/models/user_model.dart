import '../../../../core/http/http_options.dart';
import '../../domain/entities/user.dart';

class UserModel extends User{

  UserModel({
    super.id = 0,
    required super.uid,
    required super.name,
    required super.lastName,
    required super.email,
    super.address = '',
    required super.imageUrl,
    required super.phoneNumber
  });

  factory UserModel.fromJson(Map<String,dynamic> json) => UserModel(
    id: 0,
    uid: json['id'],
    name: json['first_name'],
    lastName: json['last_name'],
    email: json['email'],
    address: json['location'] ?? '',
    imageUrl: 'https://${HttpOptions.apiUrl}/assets/${json['avatar']}',
    phoneNumber: json['phone_number']
  );
}