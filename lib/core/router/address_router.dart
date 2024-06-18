part of 'router.dart';

class AddressRouter {
  static List<GoRoute> addressRoutes(GlobalKey<NavigatorState> key,ProviderRef ref) => [
    GoRoute(
      path: Routes.address,
      pageBuilder: (context,state) {
        return MaterialPage(
            key: state.pageKey,
            child: const AddressPage()
        );
      },
    ),
    GoRoute(
        parentNavigatorKey: key,
        path: Routes.addressForm,
        pageBuilder: (context,state) {
          return MaterialPage(
              key: state.pageKey,
              child: const AddressFormPage()
          );
        },
        routes: [
          GoRoute(
            path: ':id',
            pageBuilder: (context,state) {
              ref.read(storeAddressProvider.notifier).getInitialAddress(int.parse(state.pathParameters['id']!));
              return MaterialPage(
                  key: state.pageKey,
                  child: const AddressFormPage()
              );
            },
          )

        ]
    )
  ];
}