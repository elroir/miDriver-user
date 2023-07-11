import '../../domain/entities/user_vehicle.dart';

class UserVehicleModel extends UserVehicle{

  final String userId;
  final int id;
  final int makeId;
  final String transmissionType;

  UserVehicleModel({
    this.id = 0,
    required this.makeId,
    required this.transmissionType,
    required this.userId,
    required super.year,
    required super.model,
    required super.plate,
  });

  factory UserVehicleModel.fromEntity(UserVehicle user,String userId,int makeId,String transmissionType) =>
      UserVehicleModel(
          id: 0,
          makeId: makeId,
          model: user.model,
          year: user.year,
          plate: user.plate,
          transmissionType: transmissionType,
          userId: userId
      );

  Map<String,dynamic> toJson() => {
    'make'          : makeId,
    'model'         : model,
    'year'          : year,
    'plate'         : plate,
    'transmission'  : transmissionType,
    'user'          : userId
  };

}