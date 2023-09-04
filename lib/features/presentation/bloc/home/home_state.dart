part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeJokeListLoaded extends HomeState {
  final List<JokeEntity> entityList;

  const HomeJokeListLoaded(this.entityList);

  @override
  List<Object> get props => [entityList];
}

class HomeJokeListError extends HomeState {
  final String error;
  const HomeJokeListError(this.error);

  @override
  List<Object> get props => [error];
}

class HomeJokeListEmpty extends HomeState {
  @override
  List<Object> get props => [];
}
