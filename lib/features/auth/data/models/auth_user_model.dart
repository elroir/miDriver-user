import '../../../../core/http/http_options.dart';

import '../../domain/entities/auth_user.dart';

class AuthUserModel extends AuthUser{

  final String name;
  final String lastName;
  final String address;
  final int phoneNumber;

  AuthUserModel({
    required super.email,
    required super.password,
    required this.name,
    required this.lastName,
    required this.address,
    required this.phoneNumber
  });

  // factory UserModel.fromJson(Map<String,dynamic> json) =>
  //     UserModel(
  //         id: json["id"],
  //         title: json["title"],
  //         subTitle: json["subtitle"],
  //         image: json["image"],
  //         file: json["file"]
  //     );


  Map<String, dynamic> toEmailAndPasswordJson() => {
    'email'               : email,
    'password'            : password
  };


  Map<String, dynamic> toJson() => {
    'first_name'          : name,
    'last_name'           : lastName,
    'phone_number'        : phoneNumber,
    'location'            : address,
    'email'               : email,
    'password'            : password,
    'role'                : HttpOptions.userRoleId,
    'push_token'          : 'test',
  };



}