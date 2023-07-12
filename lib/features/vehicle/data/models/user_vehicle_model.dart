import '../../../../core/resources/strings_manager.dart';
import '../../domain/entities/user_vehicle.dart';
import 'car_make_model.dart';

class UserVehicleModel extends UserVehicle{

  final String userId;
  final int id;

  UserVehicleModel({
    this.id = 0,
    required this.userId,
    required super.transmissionType,
    required super.year,
    required super.model,
    required super.plate,
    required super.make
  });

  factory UserVehicleModel.fromEntity(UserVehicle user,String userId,int makeId,String transmissionType) =>
      UserVehicleModel(
          id: 0,
          model: user.model,
          make: CarMakeModel(id: makeId,makeName: ''),
          year: user.year,
          plate: user.plate,
          transmissionType: transmissionType,
          userId: userId
      );

  factory UserVehicleModel.fromJson(Map<String,dynamic> json) =>
      UserVehicleModel(
          id: json['id'],
          make: CarMakeModel.fromJson(json['make']),
          model: json['model'],
          year: json['year'],
          plate: json['plate'],
          transmissionType: toSpanishTransmission(json['transmission']),
          userId: json['user']
      );

  Map<String,dynamic> toJson() => {
    'make'          : make.id,
    'model'         : model,
    'year'          : year,
    'plate'         : plate,
    'transmission'  : transmissionType,
    'user'          : userId
  };



}
String toSpanishTransmission(String transmission){
  if(transmission=='automatic'){
    return AppStrings.automatic;
  }
  return AppStrings.manual;
}
