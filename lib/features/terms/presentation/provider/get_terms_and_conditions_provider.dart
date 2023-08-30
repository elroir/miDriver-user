
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../repositories.dart';
import '../../domain/entities/term.dart';

final getTermsAndConditionsProvider = FutureProvider<Term>(
        (ref) async {
      final result = await ref.read(Repositories.getTermsAndConditionsUseCase).call();

      return result.fold(
              (failure) => throw failure,
              (terms) => terms
      );
    }

);