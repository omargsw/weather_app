import 'package:dartz/dartz.dart';
import 'package:weather_app/core/errors/failures.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
