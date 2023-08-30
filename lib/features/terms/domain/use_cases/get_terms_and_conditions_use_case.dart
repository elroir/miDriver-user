import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/term.dart';
import '../repositories/terms_repository.dart';

class GetTermsAndConditions{

  final TermsRepository _repository;

  GetTermsAndConditions(this._repository);

  Future<Either<Failure,Term>> call() async{
    return await _repository.getTermsAndConditions();
  }
}