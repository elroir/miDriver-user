part of 'router.dart';

class AddressRouter {
  static GoRoute addressRoutes(GlobalKey<NavigatorState> key,ProviderRef ref) => GoRoute(
      parentNavigatorKey: key,
      path: Routes.address,
      pageBuilder: (context,state) {
        return MaterialPage(
            key: state.pageKey,
            child: const AddressPage()
        );
      },
    routes: [
      GoRoute(
          path: ':id',
        pageBuilder: (context,state) {
            ref.read(storeAddressProvider.notifier).getInitialAddress(int.parse(state.pathParameters['id']!));
          return MaterialPage(
              key: state.pageKey,
              child: const AddressPage()
          );
        },
      )

    ]
  );
}