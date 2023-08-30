part of 'router.dart';


class TermsRouter{

  static final termsRoutes = GoRoute(
    path: Routes.terms,
    pageBuilder: (context,state) {
      return MaterialPage(
        key: state.pageKey,
        child: const TermsAndConditionsPage()
      );
    },

  );
}