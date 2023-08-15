import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import '../../features/fare/presentation/pages/fare_page.dart';
import '../../features/service/presentation/pages/location_map_page.dart';
import '../../features/service/presentation/pages/service_form_page.dart';
import '../../features/auth/domain/entities/auth_status.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/personal_data_page.dart';
import '../../features/auth/presentation/pages/recover_password_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/register_success_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/service/presentation/pages/service_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/splash/presentation/provider/splash_provider.dart';
import '../../features/user/presentation/pages/profile_page.dart';
import '../../features/vehicle/presentation/pages/car_make_page.dart';
import '../../features/vehicle/presentation/pages/vehicle_form_page.dart';


export 'package:go_router/go_router.dart';

part 'routes.dart';
part 'register_router.dart';
part 'splash_router.dart';
part 'service_router.dart';
part 'vehicle_router.dart';
part 'user_router.dart';

final router = Provider(
        (ref) {
      GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

      return GoRouter(
          initialLocation: Routes.splash,
          navigatorKey: rootNavigatorKey,
          routes: [
            ShellRoute(
                builder: (context, state, child) {
                  return HomePage(child: child);
                },
                routes: [
                  UserRouter.userRoutes,
                  ServiceRouter.serviceRoutes(ref,rootNavigatorKey)
                 ]
            ),
            SplashRouter.splashRoutes(ref),
            AuthenticationRouter.registerRoutes,
            AuthenticationRouter.loginRoutes,
            AuthenticationRouter.accountSuccessRoutes,
            VehicleRouter.vehicleRoutes(rootNavigatorKey)
          ],
          errorPageBuilder: (context,state) => MaterialPage(
              key: state.pageKey,
              child: Scaffold(
                body: Center(child: Text(state.error.toString())),
              )
          )

      );
    }
);
