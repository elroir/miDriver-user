import '../../domain/entities/car_make.dart';

class CarMakeModel extends CarMake{

  CarMakeModel({
    required super.id,
    required super.makeName
  });
  
  factory CarMakeModel.fromJson(Map<String,dynamic> json) =>
      CarMakeModel(
        id: json['id'],
        makeName: json['name']
      );
  
}