part of 'router.dart';

class SplashRouter {
  static GoRoute splashRoutes(ProviderRef ref) => GoRoute(
    path: Routes.splash,
    redirect: (_,state) {
      final authStatus = ref.watch(splashProvider);

      if(authStatus == AuthStatus.authenticated){
       return Routes.profile;
      }

      if(authStatus==AuthStatus.notAuthenticated){
        return Routes.login;
      }

      return null;

    },
    pageBuilder: (context,state) {
      return MaterialPage(
          key: state.pageKey,
          child: const SplashPage()
      );
    },
  );
}
