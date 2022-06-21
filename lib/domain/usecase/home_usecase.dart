

import 'package:dartz/dartz.dart';
import 'package:new_project_flutter_udemy/data/network/failure.dart';
import 'package:new_project_flutter_udemy/domain/model/models.dart';
import 'package:new_project_flutter_udemy/domain/repository/repository.dart';
import 'package:new_project_flutter_udemy/domain/usecase/base_usecase.dart';

class HomeUseCase implements BaseUseCase<void,HomeObject>{
  final Repository _repository;
  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, HomeObject>> execute(void input) async{
    return await _repository.getHomeData();
  }

}