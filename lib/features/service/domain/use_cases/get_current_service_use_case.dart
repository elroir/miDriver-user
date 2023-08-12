import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/service.dart';
import '../repositories/service_repository.dart';

class GetCurrentService{
  final ServiceRepository serviceRepository;

  GetCurrentService(this.serviceRepository);

  Future<Either<Failure,Service>> call() async {
    return await serviceRepository.getCurrentService();
  }
}