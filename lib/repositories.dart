import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'core/http/http_options.dart';

import 'core/network/network_info.dart';
import 'core/network/push_notification_impl.dart';
import 'core/network/push_notification_repository.dart';
import 'core/storage/flutter_secure_storage_impl.dart';
import 'core/storage/local_storage_repository.dart';
import 'core/storage/object_box_impl.dart';
import 'core/storage/secure_storage_repository.dart';
import 'features/auth/data/data_sources/auth_remote_datasource.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/use_cases/register_use_case.dart';
import 'features/auth/domain/use_cases/request_password_recovery_use_case.dart';
import 'features/auth/domain/use_cases/save_auth_user_use_case.dart';
import 'features/auth/domain/use_cases/save_personal_data_use_case.dart';
import 'features/auth/domain/use_cases/sign_in_with_email_use_case.dart';
import 'features/auth/domain/use_cases/sign_out_use_case.dart';
import 'features/auth/domain/use_cases/verify_email_use_case.dart';
import 'features/fare/data/data_sources/fare_remote_datasource.dart';
import 'features/fare/data/repositories/fare_repository_impl.dart';
import 'features/fare/domain/repositories/fare_repository.dart';
import 'features/fare/domain/use_cases/get_fares_use_case.dart';
import 'features/map/data/data_sources/map_remote_datasource.dart';
import 'features/map/data/repositories/flutter_map_repository.dart';
import 'features/map/domain/repositories/map_repository.dart';
import 'features/map/domain/use_cases/get_directions_use_case.dart';
import 'features/map/domain/use_cases/get_picked_origin_use_case.dart';
import 'features/map/domain/use_cases/pick_origin_use_case.dart';
import 'features/splash/domain/use_cases/initial_screen_use_case.dart';
import 'features/user/data/data_sources/user_local_data_source.dart';
import 'features/user/data/data_sources/user_remote_data_source.dart';
import 'features/user/data/repositories/user_repository_impl.dart';
import 'features/user/domain/repositories/user_repository.dart';
import 'features/user/domain/use_cases/get_user_data_use_case.dart';
import 'features/user/domain/use_cases/update_user_push_token_use_case.dart';
import 'features/vehicle/data/data_sources/vehicle_remote_datasource.dart';
import 'features/vehicle/data/repositories/vehicle_repository_impl.dart';
import 'features/vehicle/domain/repositories/vehicle_repository.dart';
import 'features/vehicle/domain/use_cases/get_car_makes_use_case.dart';
import 'features/vehicle/domain/use_cases/get_user_vehicles.dart';
import 'features/vehicle/domain/use_cases/save_make_use_case.dart';
import 'features/vehicle/domain/use_cases/save_transmission_type_use_case.dart';
import 'features/vehicle/domain/use_cases/store_vehicle_use_case.dart';



class Repositories{

  Repositories._();

  //External
  // static final _imageRepository = Provider<ImageRepository>((ref) => ImagePickerImpl());
  static final _httpRepository = Provider<Client>((ref) => HttpOptions.client);
  static final _secureStorageRepository = Provider<SecureStorageRepository>((ref) => FlutterSecureStorageImpl());
  static final _storageRepository = Provider<LocalStorageRepository>((ref) => ObjectBoxImpl()..create());
  static final _networkInfoRepository = Provider<NetworkInfoRepository>((ref) => NetworkInfoImpl(InternetConnection()));
  static final _pushNotificationRepository = Provider<PushNotificationRepository>((ref) => PushNotificationImpl());


  //Data sources
  static final _authRemoteDataSource      = Provider<AuthRemoteDataSource>((ref) => AuthRemoteDataSourceImpl(ref.read(_httpRepository),ref.read(_secureStorageRepository)));
  static final _userRemoteDataSource      = Provider<UserRemoteDataSource>((ref) => UserRemoteDataSourceImpl(ref.read(_httpRepository),ref.read(_secureStorageRepository),ref.read(_pushNotificationRepository)));
  static final _userLocalDataSource       = Provider<UserLocalDataSource>((ref) => UserLocalDataSourceImpl(ref.read(_storageRepository)));
  static final _vehicleRemoteDataSource   = Provider<VehicleRemoteDataSource>((ref) => VehicleRemoteDataSourceImpl(ref.read(_httpRepository),ref.read(_secureStorageRepository)));
  static final _fareRemoteDataSource      = Provider<FareRemoteDataSource>((ref) => FareRemoteDataSourceImpl(ref.read(_httpRepository),ref.read(_secureStorageRepository)));
  static final _mapRemoteDataSource       = Provider<MapRemoteDataSource>((ref) => MapRemoteDataSourceImpl(ref.read(_httpRepository)));


  //Repositories
  static final _authRepository      = Provider<AuthRepository>((ref) => AuthRepositoryImpl(ref.read(_authRemoteDataSource)));
  static final _userRepository      = Provider<UserRepository>((ref) => UserRepositoryImpl(ref.read(_userRemoteDataSource),ref.read(_userLocalDataSource),ref.read(_networkInfoRepository)));
  static final _vehicleRepository   = Provider<VehicleRepository>((ref) => VehicleRepositoryImpl(ref.read(_vehicleRemoteDataSource),ref.read(_networkInfoRepository)));
  static final _fareRepository      = Provider<FareRepository>((ref) => FareRepositoryImpl(ref.read(_fareRemoteDataSource),ref.read(_networkInfoRepository)));
  static final _mapRepository       = Provider<MapRepository>((ref) => MapRepositoryImpl(ref.read(_mapRemoteDataSource),ref.read(_networkInfoRepository)));


  //Use cases
  static final saveAuthUserUseCase            = Provider<SaveAuthUser>((ref) => SaveAuthUser(ref.read(_authRepository)));
  static final savePersonalDataUseCase        = Provider<SavePersonalData>((ref) => SavePersonalData(ref.read(_authRepository)));
  static final registerUseCase                = Provider<SignUp>((ref) => SignUp(ref.read(_authRepository)));
  static final loginUseCase                   = Provider<SignInWithEmail>((ref) => SignInWithEmail(ref.read(_authRepository)));
  static final logoutUseCase                  = Provider<SignOut>((ref) => SignOut(ref.read(_authRepository)));
  static final verifyEmailUseCase             = Provider<VerifyEmail>((ref) => VerifyEmail(ref.read(_authRepository)));
  static final requestPasswordRecoveryUseCase = Provider<RequestPasswordRecovery>((ref) => RequestPasswordRecovery(ref.read(_authRepository)));

  static final splashUseCase                  = Provider<GetInitialPage>((ref) => GetInitialPage(ref.read(_secureStorageRepository)));


  static final updateUserTokenUseCase         = Provider<UpdateUserToken>((ref) => UpdateUserToken(ref.read(_pushNotificationRepository),ref.read(_userRepository)));
  static final getUserDataUseCase             = Provider<GetUserData>((ref) => GetUserData(ref.read(_userRepository)));

  static final getCarMakesUseCase             = Provider<GetCarMakes>((ref) => GetCarMakes(ref.read(_vehicleRepository)));
  static final storeVehicleUseCase            = Provider<StoreVehicle>((ref) => StoreVehicle(ref.read(_vehicleRepository),ref.read(_secureStorageRepository)));
  static final saveTransmissionTypeUseCase    = Provider<SaveTransmissionType>((ref) => SaveTransmissionType(ref.read(_vehicleRepository)));
  static final saveMakeIdUseCase              = Provider<SaveMakeId>((ref) => SaveMakeId(ref.read(_vehicleRepository)));
  static final getUserVehiclesUseCase         = Provider<GetUserVehicles>((ref) => GetUserVehicles(ref.read(_vehicleRepository)));

  static final getFaresUseCase                = Provider<GetFares>((ref) => GetFares(ref.read(_fareRepository)));

  static final pickOriginUseCase              = Provider<PickOrigin>((ref) => PickOrigin(ref.read(_mapRepository)));
  static final getOriginUseCase               = Provider<GetPickedOrigin>((ref) => GetPickedOrigin(ref.read(_mapRepository)));
  static final getDirectionsUseCase           = Provider<GetDirections>((ref) => GetDirections(ref.read(_mapRepository)));


}

