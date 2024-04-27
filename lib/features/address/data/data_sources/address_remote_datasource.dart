
import 'dart:convert';

import 'package:http/http.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/http/http_options.dart';
import '../../../../core/storage/secure_storage_repository.dart';
import '../models/address_model.dart';

abstract interface class AddressRemoteDataSource{
  ///Calls [HttpOptions.apiUrl]/items/address to get a list of available [AddressModel]
  ///
  /// Throws an [AuthenticationException] if token is not found
  /// Throws a [ServerException] for all error codes
  /// Throws a [SocketException] if no response is sent
  Future<List<AddressModel>> getAddresses();

  ///Calls [HttpOptions.apiUrl]/items/address to store an address
  ///
  /// Throws an [AuthenticationException] if token is not found
  /// Throws a [ServerException] for all error codes
  /// Throws a [SocketException] if no response is sent
  Future<void> storeAddress(AddressModel address);

  ///Calls [HttpOptions.apiUrl]/items/address/[addressId] to delete an address
  ///
  /// Throws an [AuthenticationException] if token is not found
  /// Throws a [ServerException] for all error codes
  /// Throws a [SocketException] if no response is sent
  Future<void> deleteAddress(int addressId);

  ///Calls [HttpOptions.apiUrl]/items/address/[address.id] to edit an address
  ///
  /// Throws an [AuthenticationException] if token is not found
  /// Throws a [ServerException] for all error codes
  /// Throws a [SocketException] if no response is sent
  Future<void> editAddress(AddressModel address);
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

  @override
  Future<void> storeAddress(AddressModel address) async {
    final url = Uri.https(HttpOptions.apiUrl,'/items/address');

    final token = await _secureStorage.getToken();

    final response = await _client.post(url,headers: {
      'Authorization': 'Bearer $token',
      'Content-Type' : 'application/json'
    },
        body: json.encode(address.toJson())
    );

    if(response.statusCode==401){
      throw AuthenticationException();
    }

    if(response.statusCode!=200){
      throw ServerException();
    }


  }

  @override
  Future<void> deleteAddress(int addressId) async {
    final url = Uri.https(HttpOptions.apiUrl,'/items/address/$addressId');

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

  }

  @override
  Future<void> editAddress(AddressModel address) async {
    final url = Uri.https(HttpOptions.apiUrl,'/items/address/${address.id}');

    final token = await _secureStorage.getToken();

    final response = await _client.patch(url,headers: {
      'Authorization': 'Bearer $token',
      'Content-Type' : 'application/json'
    },
        body: json.encode(address.toJson())
    );

    if(response.statusCode==401){
      throw AuthenticationException();
    }

    if(response.statusCode!=200){
      throw ServerException();
    }
  }



}