import 'package:dartz/dartz.dart';
import 'package:nhagiare_mobile/core/errors/failures.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;

typedef ResultVoid = Future<Either<Failure, void>>;

typedef DataMap = Map<String, dynamic>;
