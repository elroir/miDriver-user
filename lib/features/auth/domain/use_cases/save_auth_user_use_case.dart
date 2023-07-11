
import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';

class SaveAuthUser{

  final AuthRepository _authRepository;

  SaveAuthUser(this._authRepository);

  void call(String email,String password){
    final user = AuthUser(email: email, password: password);
    _authRepository.initSignUpProcess(user);
  }

}