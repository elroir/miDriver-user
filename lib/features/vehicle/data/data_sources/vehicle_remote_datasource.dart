import 'dart:convert';

import 'package:http/http.dart';
import '../models/car_make_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/http/entities/http_response.dart';
import '../../../../core/http/http_options.dart';
import '../../../../core/storage/secure_storage_repository.dart';
import '../models/transport_type_model.dart';
import '../models/user_vehicle_model.dart';

abstract interface class VehicleRemoteDataSource{
  ///Calls [HttpOptions.apiUrl]/items/car_make to get a list of available [CarMakeModel]
  ///
  /// Throws a [ServerException] for all error codes
  /// Throws a [SocketException] if no response is sent
  Future<HttpSuccess<List<CarMakeModel>>> getCarMakes();

  ///Calls [HttpOptions.apiUrl]/items/vehicle_type to get a list of available [TransportTypeModel]
  ///
  /// Throws a [ServerException] for all error codes
  /// Throws a [SocketException] if no response is sent
  Future<HttpSuccess<List<TransportTypeModel>>> getTransportTypes();

  ///Calls [HttpOptions.apiUrl]/items/vehicle to store a vehicle
  ///
  /// Throws a [ServerException] for all error codes
  /// Throws a [SocketException] if no response is sent
  Future<HttpSuccess> storeVehicle(UserVehicleModel vehicleModel);

  ///Calls [HttpOptions.apiUrl]/items/vehicle?filter={ "user": { "_eq": [UserId] }} to get a list of [UserVehicleModel]
  ///
  /// Throws a [ServerException] for all error codes
  /// Throws a [SocketException] if no response is sent
  Future<HttpSuccess<List<UserVehicleModel>>> getUserVehicles();
  ///Calls [HttpOptions.apiUrl]/items/vehicle/[vehicleId]
  ///
  /// Throws a [ServerException] for all error codes
  /// Throws a [SocketException] if no response is sent
  Future<HttpSuccess> deleteVehicle(int vehicleId);
}

class VehicleRemoteDataSourceImpl implements VehicleRemoteDataSource {

  final Client _client;
  final SecureStorageRepository _secureStorage;

  VehicleRemoteDataSourceImpl(this._client, this._secureStorage);

  @override
  Future<HttpSuccess<List<CarMakeModel>>> getCarMakes() async {
    final url = Uri.https(HttpOptions.apiUrl,'/items/car_make',{
      'fields' : 'id,name'
    });

    final token = await _secureStorage.getToken();

    final response = await _client.get(url,headers: {
      'Authorization': 'Bearer $token'
    }
    );

    final data = json.decode(response.body);

    if(response.statusCode==401){
      throw AuthenticationException();
    }

    if(response.statusCode!=200){
      throw ServerException();
    }

    final carMakes =  List<CarMakeModel>.from(data['data'].map((e) => CarMakeModel.fromJson(e)));

    return HttpSuccess(data: carMakes);
  }

  @override
  Future<HttpSuccess<List<TransportTypeModel>>> getTransportTypes() async {
    final url = Uri.https(HttpOptions.apiUrl,'/items/vehicle_type',{
      'fields' : 'id,name,icon,default'
    });

    final token = await _secureStorage.getToken();

    final response = await _client.get(url,headers: {
      'Authorization': 'Bearer $token'
    }
    );

    final data = json.decode(response.body);

    if(response.statusCode==401){
      throw AuthenticationException();
    }

    if(response.statusCode!=200){
      throw ServerException();
    }

    final transports =  List<TransportTypeModel>.from(data['data'].map((e) => TransportTypeModel.fromJson(e)));

    return HttpSuccess(data: transports);
  }

  @override
  Future<HttpSuccess> storeVehicle(UserVehicleModel userVehicleModel) async {
    final url = Uri.https(HttpOptions.apiUrl,'/items/vehicle');

    final token = await _secureStorage.getToken();

    final response = await _client.post(url,headers: {
      'Authorization': 'Bearer $token',
      'Content-Type' : 'application/json'
    },
      body: json.encode(userVehicleModel.toJson())
    );

    if(response.statusCode==401){
      throw AuthenticationException();
    }

    if(response.statusCode!=200){
      throw ServerException();
    }


    return HttpSuccess();
  }

  @override
  Future<HttpSuccess<List<UserVehicleModel>>> getUserVehicles() async {


      final userId = await _secureStorage.getUserId();

      final url = Uri.https(HttpOptions.apiUrl,'/items/vehicle',{
        'filter[user][_eq]' : '$userId',
        'fields' : 'id,make.name,make.id,model,year,plate,transmission,user'
      });

      final token = await _secureStorage.getToken();

      final response = await _client.get(url,headers: {
        'Authorization': 'Bearer $token',
        'Content-Type' : 'application/json'
      }
      );

      if(response.statusCode==401){
        throw AuthenticationException();
      }

      if(response.statusCode!=200){
        throw ServerException();
      }


      final data = json.decode(response.body)['data'];


      final vehicles = List<UserVehicleModel>.from(data.map((e)=>UserVehicleModel.fromJson(e)));


      return HttpSuccess(data: vehicles);

  }

  @override
  Future<HttpSuccess> deleteVehicle(int vehicleId) async {
    final url = Uri.https(HttpOptions.apiUrl,'/items/vehicle/$vehicleId');

    final token = await _secureStorage.getToken();

    final response = await _client.delete(url,headers: {
      'Authorization': 'Bearer $token',
      'Content-Type' : 'application/json'
    }
    );

    if(response.statusCode==401){
      throw AuthenticationException();
    }

    if(response.statusCode!=204){
      throw ServerException();
    }


    return HttpSuccess();
  }


}
