import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/http/entities/http_response.dart';
import '../../data/models/service_form_model.dart';
import '../repositories/service_repository.dart';

class StoreService{
  final ServiceRepository serviceRepository;

  StoreService(this.serviceRepository);

  Future<Either<Failure,HttpSuccess>> call(ServiceFormModel service) async {
    return await serviceRepository.storeService(service);
  }
}