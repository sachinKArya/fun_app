import 'package:dartz/dartz.dart';
import 'package:fun_app/core/error/failures.dart';
import 'package:fun_app/core/usecases/usecase.dart';
import 'package:fun_app/features/domain/entities/home/faq_item_entity.dart';
import 'package:fun_app/features/domain/repositories/home_page_repository.dart';

class GetJokesUsecase extends UseCase<List<JokeEntity>, NoParams> {
  final HomePageRepository repository;

  GetJokesUsecase(this.repository);

  @override
  Future<Either<Failure, List<JokeEntity>>> call(NoParams params) async {
    return repository.getJokes();
  }
}
