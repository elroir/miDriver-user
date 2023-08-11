import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/http/entities/http_response.dart';
import '../../data/models/service_form_model.dart';

abstract interface class ServiceRepository{
  Future<Either<Failure,HttpSuccess>> storeService(ServiceFormModel service);

}