import 'dart:convert';

import 'package:http/http.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/http/http_options.dart';
import '../../../../core/storage/secure_storage_repository.dart';
import '../models/offer_model.dart';

abstract interface class OfferRemoteDataSource{
  ///Calls [HttpOptions.apiUrl]/items/offer to get a list of available [OfferModel]
  ///
  /// Throws an [AuthenticationException] if token is not found
  /// Throws a [ServerException] for all error codes
  /// Throws a [SocketException] if no response is sent
  Future<List<OfferModel>> getOffers(int serviceId);

}

class OfferRemoteDataSourceImpl implements OfferRemoteDataSource{

  final Client _client;
  final SecureStorageRepository _secureStorage;

  OfferRemoteDataSourceImpl(this._client, this._secureStorage);

  @override
  Future<List<OfferModel>> getOffers(int serviceId) async {
    final url = Uri.https(HttpOptions.apiUrl,'/items/offer',{
      'fields' : 'id,price,driver.id,driver.avatar,driver.first_name,driver.last_name,driver.location,driver.phone_number,driver.email',
      'filter[service][_eq]' : '$serviceId'
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

    final offers =  List<OfferModel>.from(data['data'].map((e) => OfferModel.fromJson(e)));

    return offers;
  }

}