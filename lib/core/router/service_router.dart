part of 'router.dart';
class ServiceRouter {
  static GoRoute serviceRoutes = GoRoute(
      path: Routes.services,
      pageBuilder: (context,state) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: const ServicePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
        );
      },
      routes: [
        GoRoute(
          path: Routes.newService,
          name: Routes.newService,
          pageBuilder: (context,state) {
            return MaterialPage(
                key: state.pageKey,
                child: const ServiceFormPage()
            );
          },
        )
      ]

  );
}