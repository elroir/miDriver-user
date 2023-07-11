
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'secure_storage_repository.dart';

const sessionTokenKey = 'session_token';
const tokenKey = 'token';
const userIdKey = 'userId';
const driverStatusKey = 'driver_status';



class FlutterSecureStorageImpl implements SecureStorageRepository {

  final _storage = const FlutterSecureStorage();

  @override
  Future<String?> getToken() async {
    final exists = await tokenExists();
    if(!exists) return null;
    final token = await _storage.read(key: tokenKey);
    return token!;
  }

  @override
  Future<String?> getSessionToken() async {
    final exists = await _exists(sessionTokenKey);
    if(!exists) return null;
    final token = await _storage.read(key: sessionTokenKey);
    return token!;
  }

  @override
  Future<bool> tokenExists() async {
    return await _exists(tokenKey);
  }

  Future<bool> _exists(String key) async {
    try{
      const options = IOSOptions(accessibility: KeychainAccessibility.first_unlock_this_device);
      bool exists = await _storage.containsKey(key: key,iOptions: options);
      if(Platform.isIOS&&exists){
        final String? token = await _storage.read(key: key);
        exists = (token != null);
      }
      return exists;
    }catch(e){
      return false;
    }

  }

  Future<bool> _userExists() async {
    return await _exists(userIdKey);
  }

  @override
  Future<void> saveToken(String token) async {
    const options = IOSOptions(accessibility: KeychainAccessibility.first_unlock_this_device);
    return await _storage.write(key: tokenKey, value: token,iOptions: options);
  }

  @override
  Future<void> deleteToken() async {
    final exists = await tokenExists();
    if(exists){
      const options = IOSOptions(accessibility: KeychainAccessibility.first_unlock_this_device);

      await _storage.delete(key: tokenKey,iOptions: options);
      await _storage.delete(key: sessionTokenKey,iOptions: options);
    }
  }

  @override
  Future<String?> getUserId() async {
    final exists = await _userExists();
    if(!exists) return null;
    final userId = await _storage.read(key: userIdKey);
    return userId;
  }

  @override
  Future<void> saveUserId(String userId) async {
    const options = IOSOptions(accessibility: KeychainAccessibility.first_unlock_this_device);
    return await _storage.write(key: userIdKey, value: userId,iOptions: options);
  }

  @override
  Future<void> saveSessionToken(String token) async {
    const options = IOSOptions(accessibility: KeychainAccessibility.first_unlock_this_device);
    return await _storage.write(key: sessionTokenKey, value: token,iOptions: options);
  }

  @override
  Future<void> deleteAll() async {
    const options = IOSOptions(accessibility: KeychainAccessibility.first_unlock_this_device);

    await _storage.deleteAll(iOptions: options);
  }


}