import 'package:fun_app/core/mapper/mapper.dart';
import 'package:fun_app/features/data/models/home/jokes_model.dart';
import 'package:fun_app/features/domain/entities/home/faq_item_entity.dart';

class JokesModelToEntityMapper extends Mapper<List<JokesModel>, List<JokeEntity>> {
  @override
  List<JokeEntity> call(List<JokesModel> input) {
    final List<JokeEntity> entityList = [];

    for (final element in input) {
      entityList.add(
        JokeEntity(id: element.id, jokeDes: element.jokeDes),
      );
    }
    return entityList;
  }
}
