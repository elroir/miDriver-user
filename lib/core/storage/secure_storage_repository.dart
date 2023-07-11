abstract interface class SecureStorageRepository {

  Future<String?> getToken();
  Future<String?> getSessionToken();
  Future<String?> getUserId();

  Future<bool> tokenExists();
  Future<void> saveToken(String token);
  Future<void> saveSessionToken(String token);
  Future<void> saveUserId(String userId);

  Future<void> deleteToken();
  Future<void> deleteAll();

}