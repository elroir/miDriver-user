import 'package:objectbox/objectbox.dart';

@Entity()
class User {

  @Id(assignable: true)
  int id = 0;
  final String uid;
  final String name;
  final String lastName;
  final String email;
  final String address;
  final String imageUrl;
  final int phoneNumber;

  User({
    required this.id,
    required this.uid,
    required this.name,
    required this.lastName,
    required this.email,
    required this.address,
    required this.imageUrl,
    required this.phoneNumber
  });

}