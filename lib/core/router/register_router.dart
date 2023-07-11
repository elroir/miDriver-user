part of 'router.dart';
class AuthenticationRouter {

  static GoRoute registerRoutes = GoRoute(
      path: Routes.register,
      pageBuilder: (context,state) {
        return MaterialPage(
            key: state.pageKey,
            child: const RegisterPage()
        );
      },
      routes: [
        GoRoute(
          path: Routes.personalData,
          name: Routes.personalData,
          pageBuilder: (context,state) {
            return MaterialPage(
                key: state.pageKey,
                child: const PersonalDataPage()
            );
          },
        ),
      ]

  );

  static GoRoute accountSuccessRoutes = GoRoute(
      path: Routes.accountSuccess,
      name: Routes.accountSuccess,
      pageBuilder: (context,state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const RegisterSuccessPage(),
          transitionDuration: const Duration(milliseconds: 150),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              ScaleTransition(scale: animation, child: child),
        );
      }
  );


  static GoRoute loginRoutes = GoRoute(
      path: Routes.login,
      pageBuilder: (context,state) {
        return MaterialPage(
            key: state.pageKey,
            child: const LoginPage()
        );
      },
    routes: [
      GoRoute(
        path: Routes.passwordRecovery,
        name: Routes.passwordRecovery,
        pageBuilder: (context,state) {
          return MaterialPage(
              key: state.pageKey,
              child: const RecoverPasswordPage()
          );
        },
      ),
    ]
  );

}