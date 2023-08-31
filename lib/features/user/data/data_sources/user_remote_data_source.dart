import 'dart:convert';

import 'package:http/http.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/http/entities/http_response.dart';
import '../../../../core/http/http_options.dart';
import '../../../../core/network/push_notification_repository.dart';
import '../../../../core/storage/secure_storage_repository.dart';
import '../models/user_model.dart';

abstract interface class UserRemoteDataSource{
  ///Calls [HttpOptions.apiUrl]/users/me and sends a token from [PushNotificationRepository]
  ///to update users push_token
  ///
  /// Throws a [ServerException] for all error codes
  /// Throws a [SocketException] if no response is sent
  Future<HttpSuccess> updatePushToken();

  ///Calls [HttpOptions.apiUrl]/users/me to get user data
  ///returns [User] object
  ///
  /// Throws a [ServerException] for all error codes
  /// Throws a [SocketException] if no response is sent
  Future<HttpSuccess<UserModel>> getUser();

  ///Calls [HttpOptions.apiUrl]/users/[User.id] to delete current user
  ///
  /// Throws a [ServerException] for all error codes
  /// Throws a [SocketException] if no response is sent
  Future<HttpSuccess> deleteUser();

}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {

  final Client _client;
  final SecureStorageRepository _secureStorage;
  final PushNotificationRepository _pushNotificationRepository;

  UserRemoteDataSourceImpl(this._client, this._secureStorage, this._pushNotificationRepository);

  @override
  Future<HttpSuccess> updatePushToken() async {
    final url = Uri.https(HttpOptions.apiUrl,'/users/me',{
      'fields' : 'push_token'
    });

    final token = await _secureStorage.getToken();
    final pushToken = await _pushNotificationRepository.getDeviceToken();

    if(pushToken == null){
      throw PushNotificationException();
    }

    if(token == null){
      throw AuthenticationException();
    }

    final response = await _client.patch(url,headers: {
      'Authorization': 'Bearer $token',
      'Content-Type' : 'application/json'
    },
        body: json.encode(
            {
              'push_token' : pushToken
            }
        )
    );



    if(response.statusCode!=200){
      throw ServerException();
    }

    return HttpSuccess();
  }

  @override
  Future<HttpSuccess<UserModel>> getUser() async {
    final url = Uri.https(HttpOptions.apiUrl,'/users/me',{
      'fields' : 'id,first_name,last_name,email,location,phone_number,avatar'
    });

    final token = await _secureStorage.getToken();

    if(token == null){
      throw AuthenticationException();
    }

    final response = await _client.get(url,headers: {
      'Authorization': 'Bearer $token',
      'Content-Type' : 'application/json'
    }
    );

    if(response.statusCode==401){
      throw AuthenticationException();
    }

    final decoded = json.decode(response.body)['data'];



    final user = UserModel.fromJson(decoded);
    await _secureStorage.saveUserId(user.uid);

    if(response.statusCode!=200){
      throw ServerException();
    }

    return HttpSuccess(data: user);
  }

  @override
  Future<HttpSuccess> deleteUser() async {

    final userId = await _secureStorage.getUserId();

    final url = Uri.https(HttpOptions.apiUrl,'/users/$userId',);

    final token = await _secureStorage.getToken();

    if(token == null){
      throw AuthenticationException();
    }

    final response = await _client.delete(url,headers: {
      'Authorization': 'Bearer $token',
      'Content-Type' : 'application/json'
    }
    );


    if(response.statusCode!=204){
      throw ServerException();
    }
    await _secureStorage.deleteAll();

    return HttpSuccess();
  }

}