part of 'router.dart';
class ServiceRouter {
  static GoRoute serviceRoutes (ProviderRef ref,GlobalKey<NavigatorState> key) =>  GoRoute(
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
          path: Routes.fare,
          name: Routes.fare,
          parentNavigatorKey: key,
          pageBuilder: (context,state) {
            return MaterialPage(
                key: state.pageKey,
                child: const FarePage()
            );
          },
        ),
        GoRoute(
          path: '${Routes.newService}/:id',
          name: Routes.newService,
          parentNavigatorKey: key,
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