import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/http/entities/http_response.dart';
import '../../data/models/service_form_model.dart';
import '../entities/service.dart';

abstract interface class ServiceRepository{
  Future<Either<Failure,HttpSuccess>> storeService(ServiceModel service);
  Future<Either<Failure,Service>> getCurrentService();

}