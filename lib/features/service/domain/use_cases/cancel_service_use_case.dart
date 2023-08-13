import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/http/entities/http_response.dart';
import '../repositories/service_repository.dart';

class CancelService{
  final ServiceRepository _serviceRepository;

  CancelService(this._serviceRepository);

  Future<Either<Failure,HttpSuccess>> call() async {
    return await _serviceRepository.cancelService();
  }
}