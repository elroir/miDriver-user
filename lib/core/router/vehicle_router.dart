part of 'router.dart';

class VehicleRouter {
  static GoRoute vehicleRoutes(GlobalKey<NavigatorState> key) => GoRoute(
    parentNavigatorKey: key,
      path: Routes.vehicle,
      pageBuilder: (context,state) {
        return MaterialPage(
            key: state.pageKey,
            child: const VehicleFormPage()
        );
      },
    routes: [
      GoRoute(
        parentNavigatorKey: key,
        path: Routes.make,
        name: Routes.make,
        pageBuilder: (context,state) {
          return MaterialPage(
              key: state.pageKey,
              child: const CarMakePage()
          );
        },
      )
    ]
  );
}