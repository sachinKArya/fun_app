import 'dart:async';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:fun_app/core/error/exceptions.dart';
import 'package:fun_app/core/error/failures.dart';
import 'package:fun_app/core/mapper/model_to_entity/joke_model_to_entity_mapper.dart';
import 'package:fun_app/core/network/network_info.dart';
import 'package:fun_app/features/data/datasource/remote/home_page_remote_data_source.dart';
import 'package:fun_app/features/domain/entities/home/faq_item_entity.dart';
import 'package:fun_app/features/domain/repositories/home_page_repository.dart';
import 'package:http/http.dart' as http;

class HomePageRepositoryImpl implements HomePageRepository {
  final HomePageRemoteDataSource remoteDataSource;
  final JokesModelToEntityMapper mapper;

  final NetworkInfo networkInfo;

  HomePageRepositoryImpl({
    required this.remoteDataSource,
    required this.mapper,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<JokeEntity>>> getJokes() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getJokes();

        return Right(mapper.call(result));
      } on ServerException {
        return Left(ServerFailure());
      } on ServiceException {
        return Left(APIServiceFailure('Services are not responding.'));
      } on SocketException {
        return Left(ServerFailure());
      } on http.ClientException {
        return Left(ServerFailure());
      } on TimeoutException {
        return Left(TimeoutFailure("Services are taking too long to respond."));
      } catch (e) {
        return Left(UnhandledFailure("Something went wrong"));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
