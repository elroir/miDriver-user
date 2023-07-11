import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/http/entities/http_response.dart';
import '../../../../core/http/http_options.dart';
import '../../../../core/storage/secure_storage_repository.dart';
import '../../domain/entities/auth_user.dart';
import '../models/auth_user_model.dart';

abstract interface class AuthRemoteDataSource{
  ///Calls [HttpOptions.apiUrl]/files to upload an avatar, it later calls [apiUrl]/users to create a new user
  ///with [avatarId] retrieved from file creation
  ///
  /// Throws a [ServerException] for all error codes
  /// Throws a [SocketException] if no response is sent
  Future<HttpSuccess> signUp(AuthUserModel user);

  ///Calls [HttpOptions.apiUrl]/auth/login to authenticate with email and password
  ///needs an [AuthUser] with email and password
  ///
  /// Throws a [ServerException] for all error codes
  /// Throws a [SocketException] if no response is sent
  Future<HttpSuccess> signInWithEmailAndPassword(AuthUser user);

  ///Calls [HttpOptions.apiUrl]/users?filter[email][_eq] to verify if user is already registered
  ///needs a [String] email for verification
  ///
  /// Throws a [ServerException] for all error codes
  /// Throws an [AuthenticationException] if email is registered
  /// Throws a [SocketException] if no response is sent
  Future<HttpSuccess> verifyEmail(String email);

  ///Calls [HttpOptions.apiUrl]/users?filter[email][_eq] to verify if user is registered as driver
  ///needs a [String] email for verification
  ///
  /// Throws a [ServerException] for all error codes
  /// Throws an [AuthenticationException] if email is registered
  /// Throws a [SocketException] if no response is sent
  Future<HttpSuccess> verifyRole(String email);

  ///Calls [HttpOptions.apiUrl]/auth/password/request to request password recovery
  ///needs a [String] email
  ///
  /// Throws a [ServerException] for all error codes
  /// Throws an [AuthenticationException] if email is registered
  /// Throws a [SocketException] if no response is sent
  Future<HttpSuccess> requestPasswordRecovery(String email);

  ///Calls [HttpOptions.apiUrl]/users/me with queryParameters fields=id,driver_status to
  ///get user id and driver_status to save in [SecureStorageRepository]
  ///
  /// Throws a [ServerException] for all error codes
  /// Throws an [AuthenticationException] if email is registered
  /// Throws a [SocketException] if no response is sent
  Future<HttpSuccess> getUserInitialData();

  ///Calls [HttpOptions.apiUrl]/auth/logout sending a refresh token got from
  ///[SecureStorageRepository] to destroy current session
  ///
  /// Throws a [ServerException] for all error codes
  /// Throws an [AuthenticationException] if email is registered
  /// Throws a [SocketException] if no response is sent
  Future<HttpSuccess> signOut();


}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource{

  final Client _client;
  final SecureStorageRepository _secureStorage;

  AuthRemoteDataSourceImpl(this._client, this._secureStorage);

  @override
  Future<HttpSuccess> signInWithEmailAndPassword(AuthUser user) async {
    try{

      final url = Uri.https(HttpOptions.apiUrl,'/auth/login');

      final response = await _client.post(url,
          headers: {
            'Content-Type' : 'application/json'
          },
          body: json.encode({
            'email' : user.email,
            'password' : user.password
          })
      );



      if(response.statusCode!=200){
        throw ServerException();
      }
      final data = json.decode(response.body)['data'];

      await _secureStorage.saveToken(data['access_token']);
      await _secureStorage.saveSessionToken(data['refresh_token']);


      return HttpSuccess();
    }catch(e){
      throw AuthenticationException();
    }


  }

  @override
  Future<HttpSuccess> verifyEmail(String email) async {
    final url = Uri.https(HttpOptions.apiUrl,'/users',{
      'filter[email][_eq]' : email,
      'fields'             : 'email,role'
    });

    final response = await _client.get(url,
        headers: {
          'Authorization': HttpOptions.apiToken,
          'Content-Type' : 'application/json'
        },
    );
    final data = json.decode(response.body)['data'];

    if(response.statusCode!=200){
      throw ServerException();
    }

    if (!data.isEmpty){
      if(data.first['role']!=HttpOptions.userRoleId){
        throw RoleException();
      }
      throw AuthenticationException();
    }


    return HttpSuccess();
  }

  @override
  Future<HttpSuccess> verifyRole(String email) async {
    final url = Uri.https(HttpOptions.apiUrl,'/users',{
      'filter[email][_eq]' : email,
      'fields'             : 'role'
    });

    final response = await _client.get(url,
      headers: {
        'Authorization': HttpOptions.apiToken,
        'Content-Type' : 'application/json'
      },
    );
    final data = json.decode(response.body)['data'];

    if(response.statusCode!=200){
      throw ServerException();
    }

    if (!data.isEmpty){
      if(data.first['role']!=HttpOptions.userRoleId){
        throw RoleException();
      }
    }


    return HttpSuccess();
  }

  @override
  Future<HttpSuccess> signUp(AuthUserModel user) async {

    const baseUrl = HttpOptions.apiUrl;


    final url = Uri.https(baseUrl,'/users');

    final response = await _client.post(url,
        body: json.encode(user.toJson()),
      headers: {
        'Authorization': HttpOptions.apiToken,
        'Content-Type' : 'application/json'
      }
    );
    final decoded = json.decode(response.body)['data'];


    if(response.statusCode!=200){
      throw ServerException();
    }
    await _secureStorage.saveUserId(decoded['id']);


    return HttpSuccess();

  }


  @override
  Future<HttpSuccess> requestPasswordRecovery(String email) async {
    final url = Uri.https(HttpOptions.apiUrl,'/auth/password/request');


    final response = await _client.post(url,
        headers: {
          'Content-Type' : 'application/json'
        },
        body: json.encode({
          'email' : email,
        })
    );


    if(response.statusCode!=204){
      throw ServerException();
    }


    return HttpSuccess();
  }

  @override
  Future<HttpSuccess> signOut() async {

      final url = Uri.https(HttpOptions.apiUrl,'/auth/logout');

      final refreshToken = await _secureStorage.getSessionToken();

      if(refreshToken==null){
        throw AuthenticationException();
      }

      final response = await _client.post(url,
          headers: {
            'Content-Type' : 'application/json'
          },
          body: json.encode({
            'refresh_token' : refreshToken,
          })
      );


      if(response.statusCode!=204){
        throw ServerException();
      }

      await _secureStorage.deleteAll();

      return HttpSuccess();

  }

  @override
  Future<HttpSuccess> getUserInitialData() async {
    final url = Uri.https(HttpOptions.apiUrl,'/users/me',{
      'fields' : 'id'
    });

    final token = await _secureStorage.getToken();

    if(token==null){
      throw AuthenticationException();
    }

    final response = await _client.get(url,
        headers: {
          'Content-Type' : 'application/json',
          'Authorization': 'Bearer $token',
        },
    );


    if(response.statusCode!=200){
      throw ServerException();
    }

    final data = json.decode(response.body)['data'];

    await _secureStorage.saveUserId(data['id']);


    return HttpSuccess();
  }



  
}