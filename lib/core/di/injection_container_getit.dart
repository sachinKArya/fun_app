import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fun_app/core/mapper/model_to_entity/joke_model_to_entity_mapper.dart';
import 'package:fun_app/core/network/network_info.dart';
import 'package:fun_app/core/util/local_db_service.dart';
import 'package:fun_app/features/data/datasource/local/home_page_local_data_source.dart';
import 'package:fun_app/features/data/datasource/remote/home_page_remote_data_source.dart';
import 'package:fun_app/features/data/datasource/remote/network_client/api_service.dart';
import 'package:fun_app/features/data/repositories/home_page_repository_impl.dart';
import 'package:fun_app/features/domain/repositories/home_page_repository.dart';
import 'package:fun_app/features/domain/usecases/home/get_jokes_usecase.dart';
import 'package:fun_app/features/presentation/bloc/home/home_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

// sl - Service locator
final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => HomeBloc(sl()));

  // Use cases
  sl.registerLazySingleton(() => GetJokesUsecase(sl()));

  // Repository
  sl.registerLazySingleton<HomePageRepository>(
    () => HomePageRepositoryImpl(
      remoteDataSource: sl(),
      mapper: sl(),
      networkInfo: sl(),
    ),
  );

  // Mapper
  sl.registerLazySingleton(() => JokesModelToEntityMapper());

  // Data sources
  sl.registerLazySingleton<HomePageLocalDataSource>(
    () => HomePageLocalDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<HomePageRemoteDataSource>(
    () => HomePageRemoteDataSourceImpl(sl(), sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton<SqliteService>(() => SqliteService());
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => ApiService.create());
  //Remote Config firebase
  sl.registerLazySingleton(
    () => SqliteService().initializeDB(),
  );
}
