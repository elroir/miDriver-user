import 'dart:convert';

import 'package:http/http.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/http/entities/http_response.dart';
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
  ///Calls [HttpOptions.apiUrl]/items/offer/[offerId] to change offer status
  ///to accepted
  ///
  /// Throws an [AuthenticationException] if token is not found
  /// Throws a [ServerException] for all error codes
  /// Throws a [SocketException] if no response is sent
  Future<HttpSuccess> acceptOffer(int offerId);
}

class OfferRemoteDataSourceImpl implements OfferRemoteDataSource{

  final Client _client;
  final SecureStorageRepository _secureStorage;

  OfferRemoteDataSourceImpl(this._client, this._secureStorage);

  @override
  Future<List<OfferModel>> getOffers(int serviceId) async {
    final url = Uri.https(HttpOptions.apiUrl,'/items/offer',{
      'fields' : 'id,price,status,distance,driver.id,driver.avatar,driver.first_name,driver.last_name,driver.location,driver.phone_number,driver.email',
      'filter' : '{ "service": { "_eq": "$serviceId" },'
          '"status": { "_nin": ["cancelled"] }}'
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

  @override
  Future<HttpSuccess> acceptOffer(int offerId) async {
    const baseUrl = HttpOptions.apiUrl;

    final token = await _secureStorage.getToken();

    final url = Uri.https(baseUrl,'/items/offer/$offerId');

    final response = await _client.patch(url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type' : 'application/json'
        },body: json.encode({
          'status':'accepted'
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