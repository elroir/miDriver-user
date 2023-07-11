import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class NetworkInfoRepository{
  Future<bool> get isConnected;
}


class NetworkInfoImpl implements NetworkInfoRepository{

  final InternetConnectionCheckerPlus connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;

}