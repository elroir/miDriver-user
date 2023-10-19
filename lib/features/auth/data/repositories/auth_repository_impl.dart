import 'package:fpdart/fpdart.dart';

import '../../../../core/error/error_messages.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/http/entities/http_response.dart';
import '../../domain/entities/auth_user.dart';

import '../../domain/entities/personal_data.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_remote_datasource.dart';
import '../models/auth_user_model.dart';

class AuthRepositoryImpl implements AuthRepository{

  AuthUser? _authUser;
  PersonalData? _personalData;
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl(this._authRemoteDataSource);

  @override
  void initSignUpProcess(AuthUser user) {
    _authUser = user;
  }

  @override
  Future<Either<Failure, HttpSuccess>> signInWithEmail(AuthUser user) async {
    try{

      await _authRemoteDataSource.signInWithEmailAndPassword(user);

      return Right(HttpSuccess());

    }on ServerException {
      return Left(ServerFailure());
    }on AuthenticationException{
      return Left(AuthFailure());
    }
  }

  @override
  Future<Either<Failure, HttpSuccess>> signUp() async {
    try{
      final authUserModel = AuthUserModel(
          email: _authUser!.email,
          password: _authUser!.password,
          name: _personalData!.name,
          lastName: _personalData!.lastName,
          phoneNumber: _personalData!.phone
      );
      final resp = await _authRemoteDataSource.signUp(authUserModel);
      return Right(resp);

    }on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, HttpSuccess>> verifyEmail(String email) async {
    try{

      final resp = await _authRemoteDataSource.verifyEmail(email);
      return Right(resp);

    }on ServerException {
      return Left(ServerFailure());
    }on AuthenticationException{
      return Left(AuthFailure(errorMessage: ErrorMessages.userIsAlreadyRegistered));
    }on RoleException{
      return Left(RoleFailure());
    }
  }

  @override
  Future<Either<Failure, HttpSuccess>> verifyRole(String email) async {
    try{

      final resp = await _authRemoteDataSource.verifyRole(email);
      return Right(resp);

    }on ServerException {
      return Left(ServerFailure());
    }on RoleException{
      return Left(RoleFailure());
    }
  }

  @override
  void savePersonalData(PersonalData personalData) {
    _personalData = personalData;
  }


  @override
  Future<Either<Failure, HttpSuccess>> signOut() async {
    try{

      final resp = await _authRemoteDataSource.signOut();
      return Right(resp);

    }on ServerException {
      return Left(ServerFailure());
    }on AuthenticationException{
      return Left(AuthFailure());
    }
  }

  @override
  Either<Failure, AuthUser> get user => _authUser==null
      ? Left(NullFailure(
    errorMessage: ErrorMessages.userNullError
  ))
      : Right(_authUser!);


  @override
  Future<Either<Failure, HttpSuccess>> requestPasswordRecovery(String email) async {
    try{
      final resp = await _authRemoteDataSource.requestPasswordRecovery(email);
      return Right(resp);
    }on ServerException {
      return Left(ServerFailure());
    }on AuthenticationException{
      return Left(AuthFailure());
    }
  }



}