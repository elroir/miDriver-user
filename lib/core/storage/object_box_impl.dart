import '../../features/user/domain/entities/user.dart';
import '../../objectbox.g.dart';

import 'local_storage_repository.dart';

class ObjectBoxImpl implements LocalStorageRepository{

  late final Store _store;
  late final Box<User> _userBox;


  User? _getUser() => _userBox.get(1);

  @override
  Future<void> create() async {
    _store = await openStore();
    _userBox = Box<User>(_store);

  }

  @override
  Future<Object?> getObject(String key) async {
    if(key=='user') {
      return _getUser();
    }

    return null;
  }

  @override
  Future<void> saveObject(String key, Object data) async {
    if(key=='user'&&data is User) {
      data.id=1;
      _userBox.put(data);
    }
  }

  @override
  Future<void> deleteObject(String key) async {
    if(key=='user'){
      _userBox.remove(0);
    }
  }



}