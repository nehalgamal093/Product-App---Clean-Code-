import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:new_project_flutter_udemy/app/app_prefs.dart';
import 'package:new_project_flutter_udemy/data/data_source/local_data_source.dart';
import 'package:new_project_flutter_udemy/data/data_source/remote_data_source.dart';
import 'package:new_project_flutter_udemy/data/network/app_api.dart';
import 'package:new_project_flutter_udemy/data/network/dio_factory.dart';
import 'package:new_project_flutter_udemy/data/network/network_info.dart';
import 'package:new_project_flutter_udemy/data/repository/repository_impl.dart';
import 'package:new_project_flutter_udemy/domain/repository/repository.dart';
import 'package:new_project_flutter_udemy/domain/usecase/login_usecase.dart';
import 'package:new_project_flutter_udemy/presentation/login/viewmodel/login_viewmodel.dart';
import 'package:new_project_flutter_udemy/presentation/register/viewmodel/register_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/usecase/home_usecase.dart';
import '../domain/usecase/register_usecase.dart';
import '../presentation/main/pages/home/viewmodel/home_viewmodel.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // app module, its a module where we put all generic dependencies

  //shared prefs instance
  final sharePrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharePrefs);

  //app prefs instance
  instance
      .registerLazySingleton<AppPrefrences>(() => AppPrefrences(instance()));

  // network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  //dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  Dio dio = await instance<DioFactory>().getDio();

  //app service client
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  //remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance()));


  instance.registerLazySingleton<LocalDataSource>(
          () => LocalDataSourceImpl());

  //repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance(),instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance
        .registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(instance()));

    instance.registerFactory<ImagePicker>(() => ImagePicker());
  }
}

initHomeModule() {
  if (!GetIt.I.isRegistered<HomeUseCase>()) {
    instance.registerFactory<HomeUseCase>(() => HomeUseCase(instance()));
    instance.registerFactory<HomeViewModel>(() => HomeViewModel(instance()));
  }
}
