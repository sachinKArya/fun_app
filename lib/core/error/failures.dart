import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {}

class LocalDBFailure extends Failure {}

class NetworkFailure extends Failure {}

class ServiceFailure extends Failure {}

///Returned when when a scheduled timeout happens while waiting for an async result.
class TimeoutFailure extends Failure {
  final String errorMessage;

  TimeoutFailure(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

class APIServiceFailure extends Failure {
  final String errorMessage;

  APIServiceFailure(this.errorMessage);
}

class AuthTokenFailure extends Failure {
  final String errorMessage;
  AuthTokenFailure(this.errorMessage);
}

class InvalidUserIdFailure extends Failure {
  InvalidUserIdFailure();
}

class AuthTokenRefreshFailure extends Failure {
  AuthTokenRefreshFailure();
}

class UnhandledFailure extends Failure {
  final String errorMessage;

  UnhandledFailure(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
