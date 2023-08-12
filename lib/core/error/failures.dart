
import 'error_messages.dart';

abstract class Failure{

  final String errorMessage;
  
  const Failure({
    this.errorMessage = ''
  });


}

//General failures
class ServerFailure extends Failure{

  ServerFailure({super.errorMessage = ErrorMessages.serverFailureMessageError});

}

class SocketFailure extends Failure{}

class CacheFailure extends Failure{}

class NullFailure extends Failure{
  NullFailure({required super.errorMessage});
}

class PushNotificationFailure extends Failure{}

class NoServiceFailure extends Failure{}


class AuthFailure extends Failure{
  AuthFailure({super.errorMessage = ErrorMessages.genericAuthMessageError});
}

class RoleFailure extends Failure{
  RoleFailure({super.errorMessage = ErrorMessages.userIsRegisteredInOtherApp});
}

class ValidationFailure extends Failure{
  ValidationFailure({required super.errorMessage});
}

class ImageFailure extends Failure{
  ImageFailure({super.errorMessage = ErrorMessages.galleryMessageError});
}

class LocationPermissionFailure extends Failure{}

class LocationServicesFailure extends Failure{}