import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fun_app/core/usecases/usecase.dart';
import 'package:fun_app/features/domain/entities/home/faq_item_entity.dart';
import 'package:fun_app/features/domain/usecases/home/get_jokes_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetJokesUsecase usecase;

  HomeBloc(this.usecase) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is GetJokesList) {
        final failureOrSuccess = await usecase(NoParams());
        failureOrSuccess.fold((failure) {
          emit(const HomeJokeListError("Error while fetching data."));
        }, (success) {
          emit(HomeJokeListLoaded(success));
        });
      }
    });
  }
}
