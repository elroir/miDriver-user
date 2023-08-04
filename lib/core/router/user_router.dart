part of 'router.dart';

class UserRouter{

  static final userRoutes = GoRoute(
    path: Routes.profile,
    pageBuilder: (context,state) {
      return CustomTransitionPage(
        key: state.pageKey,
        child: const ProfilePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      );
    },

  );
}