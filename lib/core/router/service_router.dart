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
          path: Routes.finishedService,
          name: Routes.finishedService,
          parentNavigatorKey: key,
          pageBuilder: (context,state) {
            return MaterialPage(
                key: state.pageKey,
                child: const ServiceFinishedPage()
            );
          },
        ),
        GoRoute(
          path: Routes.location,
          parentNavigatorKey: key,
          pageBuilder: (context,state) {
            final lat = state.uri.queryParameters['lat'] ?? '';
            final long = state.uri.queryParameters['lon'] ?? '';
            if(num.tryParse(lat)==null||num.tryParse(long)==null){
              return MaterialPage(
                  key: state.pageKey,
                  child: const ServicePage()
              );
            }
            return MaterialPage(
                key: state.pageKey,
                child: LocationMapPage(location: LatLng(double.parse(lat), double.parse(long)))
            );
          },
        ),
        GoRoute(
          path: '${Routes.newService}/:id',
          name: Routes.newService,
          parentNavigatorKey: key,
          pageBuilder: (context,state) {
            final fareId = int.parse(state.pathParameters['id']!);

            return MaterialPage(
                key: state.pageKey,
                child: ServiceFormPage(fareId: fareId)
            );
          },
        )
      ]

  );
}