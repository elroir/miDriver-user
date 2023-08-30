import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/resources/strings_manager.dart';
import '../../../../core/resources/values_manager.dart';
import '../../../../core/router/router.dart';
import '../../../home/presentation/pages/error_view.dart';
import '../provider/get_terms_and_conditions_provider.dart';

class TermsAndConditionsPage extends ConsumerWidget{
  const TermsAndConditionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context,ref) {

    final terms = ref.watch(getTermsAndConditionsProvider);

    return Scaffold(
      body: terms.when(
        skipLoadingOnRefresh: false,
          data: (terms) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.horizontalPadding),
              child: Column(
                children: [
                  Html(
                      data: terms.description + terms.descriptionExtended,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: FractionallySizedBox(
                          widthFactor: 0.9,
                          child: OutlinedButton(
                              onPressed: ()=> context.pop(),
                              child: const Text('No ${AppStrings.acceptI}')
                          ),
                        ),
                      ),
                      Flexible(
                        child: FractionallySizedBox(
                          widthFactor: 0.9,
                          child: ElevatedButton(
                              onPressed: () => context.goNamed(Routes.personalData),
                              child: const Text(AppStrings.acceptI)
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30)

                ],
              ),
            ),
          ),
          error: (error,_) => ErrorView(onTap: () => ref.invalidate(getTermsAndConditionsProvider)),
          loading: () => const Center(child: CircularProgressIndicator.adaptive())
      )
    );
  }
}
