import '../../../../core/storage/secure_storage_repository.dart';

class GetUserId{
  final SecureStorageRepository _storageRepository;

  GetUserId(this._storageRepository);

  Future<String?> call() async {
    return await _storageRepository.getUserId();
  }
}