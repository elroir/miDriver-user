import 'dart:convert';

import 'package:http/http.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/http/http_options.dart';
import '../../../../core/storage/secure_storage_repository.dart';
import '../models/fare_model.dart';

abstract interface class FareRemoteDataSource{
  ///Calls [HttpOptions.apiUrl]/items/fare to get a list of available [FareModel]
  ///
  /// Throws an [AuthenticationException] if token is not found
  /// Throws a [ServerException] for all error codes
  /// Throws a [SocketException] if no response is sent
  Future<List<FareModel>> getFares();

}

class FareRemoteDataSourceImpl implements FareRemoteDataSource{


  final Client _client;
  final SecureStorageRepository _secureStorage;

  FareRemoteDataSourceImpl(this._client, this._secureStorage);

  @override
  Future<List<FareModel>> getFares() async {
    final url = Uri.https(HttpOptions.apiUrl,'/items/fare',{
      'fields' : 'id,name,description,icon,location'
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

    final fares =  List<FareModel>.from(data['data'].map((e) => FareModel.fromJson(e)));

    return fares;
  }

}