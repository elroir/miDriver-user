import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/term.dart';

abstract interface class TermsRepository{
  Future<Either<Failure,Term>> getTermsAndConditions();
}