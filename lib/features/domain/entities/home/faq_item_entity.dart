import 'package:equatable/equatable.dart';

class JokeEntity extends Equatable {
  final int? id;
  final String? jokeDes;

  const JokeEntity({this.id, this.jokeDes});

  @override
  List<Object?> get props => [id, jokeDes];
}
