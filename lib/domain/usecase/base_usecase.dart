import 'package:dartz/dartz.dart';
import 'package:new_project_flutter_udemy/data/network/failure.dart';

abstract class BaseUseCase<In, Out> {
  Future<Either<Failure, Out>> execute(In input);
}
