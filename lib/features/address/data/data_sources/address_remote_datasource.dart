
import 'dart:convert';

import 'package:http/http.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/http/http_options.dart';
import '../../../../core/storage/secure_storage_repository.dart';
import '../models/address_model.dart';

abstract interface class AddressRemoteDataSource{
  ///Calls [HttpOptions.apiUrl]/items/address to get a list of available [FareModel]
  ///
  /// Throws an [AuthenticationException] if token is not found
  /// Throws a [ServerException] for all error codes
  /// Throws a [SocketException] if no response is sent
  Future<List<AddressModel>> getAddresses();

}

class AddressRemoteDataSourceImpl implements AddressRemoteDataSource{


  final Client _client;
  final SecureStorageRepository _secureStorage;

  AddressRemoteDataSourceImpl(this._client, this._secureStorage);

  @override
  Future<List<AddressModel>> getAddresses() async {

    final userId = await _secureStorage.getUserId();

    final url = Uri.https(HttpOptions.apiUrl,'/items/address',{
      'filter[user][_eq]' : '$userId'
      // 'fields' : 'id,address,location,icon,price,location'
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

    final addresses =  List<AddressModel>.from(data['data'].map((e) => AddressModel.fromJson(e)));

    return addresses;
  }

}