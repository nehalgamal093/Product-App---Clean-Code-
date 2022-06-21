import 'package:new_project_flutter_udemy/data/data_source/local_data_source.dart';
import 'package:new_project_flutter_udemy/data/data_source/remote_data_source.dart';
import 'package:new_project_flutter_udemy/data/mapper/mapper.dart';
import 'package:new_project_flutter_udemy/data/network/error_handler.dart';
import 'package:new_project_flutter_udemy/data/network/network_info.dart';
import 'package:new_project_flutter_udemy/domain/model/models.dart';
import 'package:new_project_flutter_udemy/data/network/requests.dart';
import 'package:new_project_flutter_udemy/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:new_project_flutter_udemy/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;
  RepositoryImpl(this._remoteDataSource, this._networkInfo,this._localDataSource);
  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == ApiInternalStatus.SUCCESS) {
          //sucess
          //return data
          return Right(response.toDomain());
        } else {
          //failure
          //return businnes error
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.register(registerRequest);
        if (response.status == ApiInternalStatus.SUCCESS) {
          //sucess
          //return data
          return Right(response.toDomain());
        } else {
          //failure
          //return businnes error
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, HomeObject>> getHomeData() async{
    try{
      final response = await _localDataSource.getHomeData();
      return Right(response.toDomain());
      //get response from cache
    }catch(cacheError){
      //cache is not existing or cache is not valid

      //its the time to get API side
    }


    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getHomeData();
        if (response.status == ApiInternalStatus.SUCCESS) {
          //sucess
          //return data
          _localDataSource.saveHomeToCache(response);
          return Right(response.toDomain());
        } else {
          //failure
          //return businnes error
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

}
