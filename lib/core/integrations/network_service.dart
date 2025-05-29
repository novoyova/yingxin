import 'package:internet_connection_checker/internet_connection_checker.dart';

final class NetworkService {
  static const String className = 'NetworkService';

  final InternetConnectionChecker _internetConnectionChecker;

  const NetworkService({
    required InternetConnectionChecker internetConnectionChecker,
  }) : _internetConnectionChecker = internetConnectionChecker;

  Future<bool> hasConnection() async {
    return await _internetConnectionChecker.hasConnection;
  }
}
