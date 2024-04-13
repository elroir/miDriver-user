part of 'router.dart';

class AddressRouter {
  static GoRoute addressRoutes(GlobalKey<NavigatorState> key) => GoRoute(
      parentNavigatorKey: key,
      path: Routes.address,
      pageBuilder: (context,state) {
        return MaterialPage(
            key: state.pageKey,
            child: const AddressPage()
        );
      },
  );
}