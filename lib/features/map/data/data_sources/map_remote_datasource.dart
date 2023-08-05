import 'dart:convert';

import 'package:http/http.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/error/exceptions.dart';
import '../models/direction_model.dart';

abstract interface class MapRemoteDataSource {
  ///Calls https://api.mapbox.com/directions/v5/mapbox/driving/[origin.longitude],[origin.latitude];[destination.longitude],[destination.latitude]
  /// to get a [DirectionModel]
  ///
  /// Throws a [ServerException] for all error codes
  /// Throws a [SocketException] if no response is sent
  Future<DirectionModel> getDirections(LatLng origin,LatLng destination);



}


class MapRemoteDataSourceImpl implements MapRemoteDataSource{

  final Client _client;

  MapRemoteDataSourceImpl(this._client);

  @override
  Future<DirectionModel> getDirections(LatLng origin, LatLng destination) async{
    final url = Uri.https('api.mapbox.com',
        '/directions/v5/mapbox/driving/${origin.longitude},${origin.latitude};${destination.longitude},${destination.latitude}',{
      'access_token' : 'pk.eyJ1IjoiZWxyb2lyIiwiYSI6ImNrOGF2Mmk5dzAxZHkzaGxlZTY2MngzbnYifQ.brKQi8vR4GK6vzDKewAuMw'
    });


    final response = await _client.get(url);

    final data = json.decode(response.body);

    if(response.statusCode!=200){
      throw ServerException();
    }

    final direction =  DirectionModel.fromJson(data);

    return direction;
  }

}