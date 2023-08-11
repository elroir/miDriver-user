import 'car_make.dart';

class UserVehicle{

  final int id;
  final int year;
  final String model;
  final String plate;
  final String transmissionType;
  final CarMake make;

  UserVehicle({
    this.id = 0,
    required this.year,
    required this.model,
    required this.plate,
    this.transmissionType = 'automatic',
    this.make = const CarMake(id: 0,makeName:'')
  });

}