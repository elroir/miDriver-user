abstract interface class LocalStorageRepository<T> {
  Future<T> create();

  Future<Object?> getObject(String key);
  Future<void> saveObject(String key,Object data);
  Future<void> deleteObject(String key);
}