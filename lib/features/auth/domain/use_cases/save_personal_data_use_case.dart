import '../entities/personal_data.dart';
import '../repositories/auth_repository.dart';

class SavePersonalData{

  final AuthRepository _authRepository;

  SavePersonalData(this._authRepository);

  void call(PersonalData personalData){

    _authRepository.savePersonalData(personalData);
  }

}