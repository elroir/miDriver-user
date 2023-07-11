import '../../../../core/storage/secure_storage_repository.dart';
import '../../../auth/domain/entities/auth_status.dart';

class GetInitialPage{

  final SecureStorageRepository _repository;

  GetInitialPage(this._repository);

  Future<AuthStatus> call() async {

    final token = await _repository.getToken();


    if(token!=null){

      return AuthStatus.authenticated;
    }

    return AuthStatus.notAuthenticated;

  }

}