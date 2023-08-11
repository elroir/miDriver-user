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
  /// Throws a [ServerException] for all error codes
  /// Throws a [SocketException] if no response is sent
  Future<HttpSuccess> storeService(ServiceFormModel service);
}

class ServiceRemoteDataSourceImpl implements ServiceRemoteDataSource{

  final Client _client;
  final SecureStorageRepository _secureStorage;

  ServiceRemoteDataSourceImpl(this._client, this._secureStorage);

  @override
  Future<HttpSuccess> storeService(ServiceFormModel service) async {

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

    if(response.statusCode!=200){
      throw ServerException();
    }


    return HttpSuccess();
  }

}