import 'dart:convert';

import 'package:http/http.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/http/entities/http_response.dart';
import '../../../../core/http/http_options.dart';
import '../../../../core/storage/secure_storage_repository.dart';
import '../models/service_form_model.dart';

abstract interface class ServiceRemoteDataSource{
  ///Calls [HttpOptions.apiUrl]/items/service to register a new Service
  ///needs a [ServiceFormModel]
  ///
  ///  Throws an [AuthenticationException] for code 401
  /// Throws a [ServerException] for all other error codes
  /// Throws a [SocketException] if no response is sent
  Future<HttpSuccess> storeService(ServiceModel service);
  ///Calls [HttpOptions.apiUrl]/items/service to get current service
  ///
  ///  Throws an [AuthenticationException] for code 401
  /// Throws a [ServerException] for all other error codes
  /// Throws a [SocketException] if no response is sent
  Future<ServiceModel> getCurrentService();
  ///Calls [HttpOptions.apiUrl]/items/service/[serviceId] to cancel current service
  ///  Throws an [AuthenticationException] for code 401
  /// Throws a [ServerException] for all other error codes
  /// Throws a [SocketException] if no response is sent
  Future<HttpSuccess> cancelCurrentService(int serviceId);
}

class ServiceRemoteDataSourceImpl implements ServiceRemoteDataSource{

  final Client _client;
  final SecureStorageRepository _secureStorage;

  ServiceRemoteDataSourceImpl(this._client, this._secureStorage);

  @override
  Future<HttpSuccess> storeService(ServiceModel service) async {

    const baseUrl = HttpOptions.apiUrl;

    final token = await _secureStorage.getToken();
    final userId = await _secureStorage.getUserId();

    final url = Uri.https(baseUrl,'/items/service');

    final response = await _client.post(url,
        body: json.encode(service.toJson(userId!)),
        headers: {
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


    return HttpSuccess();
  }

  @override
  Future<ServiceModel> getCurrentService() async{
    const baseUrl = HttpOptions.apiUrl;

    final token = await _secureStorage.getToken();
    final userId = await _secureStorage.getUserId();

    final url = Uri.https(baseUrl,'/items/service',{
      'fields' : 'id,date_created,status,vehicle.*,vehicle.make.*,total_distance,total_price,from,to,fare.*,date',
      'filter' : '{ "client": { "_eq": "$userId" },'
          '"status": { "_in": ["published","approved","in_progress"] }}'
    });

    final response = await _client.get(url,
        headers: {
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

    final data = json.decode(response.body);

    if(data['data'].isEmpty){
      throw NoDataException();
    }

    final service = ServiceModel.fromJson(data['data'][0]);


    return service;
  }

  @override
  Future<HttpSuccess> cancelCurrentService(int serviceId) async {
    const baseUrl = HttpOptions.apiUrl;

    final token = await _secureStorage.getToken();

    final url = Uri.https(baseUrl,'/items/service/$serviceId');

    final response = await _client.patch(url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type' : 'application/json'
        },body: json.encode({
          'status':'cancelled'
        })
    );


    if(response.statusCode==401){
      throw AuthenticationException();
    }

    if(response.statusCode!=200){
      throw ServerException();
    }



    return HttpSuccess();
  }

}