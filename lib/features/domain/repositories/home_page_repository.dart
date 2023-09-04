import 'package:dartz/dartz.dart';
import 'package:fun_app/core/error/failures.dart';
import 'package:fun_app/features/domain/entities/home/faq_item_entity.dart';

abstract class HomePageRepository {
  Future<Either<Failure, List<JokeEntity>>> getJokes();
}
