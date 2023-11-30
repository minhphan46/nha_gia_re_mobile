import 'package:equatable/equatable.dart';
import 'package:nhagiare_mobile/core/errors/exceptions.dart';

abstract class Failure extends Equatable {
  const Failure({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final int statusCode;

  String get errorMessage => '$statusCode - Error: $message';

  @override
  List<Object?> get props => [message, statusCode];
}

class ApiFailure extends Failure {
  const ApiFailure({
    required super.message,
    required super.statusCode,
  });

  ApiFailure.fromException(
    ApiException exception,
  ) : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}

class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    required super.statusCode,
  });

  ServerFailure.fromException(
    ServerException exception,
  ) : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}

class ConnectionFailure extends Failure {
  const ConnectionFailure({
    required super.message,
    required super.statusCode,
  });

  ConnectionFailure.fromException(
    ServerException exception,
  ) : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}

class DatabaseFailure extends Failure {
  const DatabaseFailure({
    required super.message,
    required super.statusCode,
  });

  DatabaseFailure.fromException(
    ServerException exception,
  ) : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}

class SharedPreferencesFailure extends Failure {
  const SharedPreferencesFailure({
    required super.message,
    required super.statusCode,
  });

  SharedPreferencesFailure.fromException(
    ServerException exception,
  ) : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}

class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    required super.statusCode,
  });

  CacheFailure.fromException(
    ServerException exception,
  ) : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}
