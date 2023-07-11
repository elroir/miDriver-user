import '../../../../core/error/exceptions.dart';
import '../../../../core/storage/local_storage_repository.dart';
import '../../domain/entities/user.dart';

abstract interface class UserLocalDataSource{
  ///gets the [User] which was stored the last time
  ///the user had an internet connection
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<User> getStoredUserData();
  Future<void> cacheUser(User user);

}
class UserLocalDataSourceImpl implements UserLocalDataSource {
  final LocalStorageRepository _localStorageRepository;

  UserLocalDataSourceImpl(this._localStorageRepository);


  @override
  Future<void> cacheUser(User user) async {
    await _localStorageRepository.saveObject('user', user);
  }

  @override
  Future<User> getStoredUserData() async {
    final user = await _localStorageRepository.getObject('user');
    if(user != null){
      return user as User;
    } else {
      throw CacheException();
    }
  }

}
