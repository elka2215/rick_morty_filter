import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty/domain/model/character_model.dart';
import 'package:rick_morty/screens/chatacter/bloc/bloc_event.dart';
import 'package:rick_morty/screens/chatacter/bloc/bloc_state.dart';
import 'package:rick_morty/screens/chatacter/repository/repository_characters.dart';
import 'package:rick_morty/screens/chatacter/widgets_characters/show_modal_filters.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final UserRepository userRepository;

  CharactersBloc(this.userRepository) : super(LoadingCharactersState()) {
    on<InitialCharactersEvent>(_onInitialCharactersEvent);
    on<FilterCharactersEvent>(_onFilterCharactersEvent);
    on<PaginationEvent>(_onPagination);
  }

  FutureOr<void> _onInitialCharactersEvent(
      InitialCharactersEvent event, Emitter<CharactersState> emit) async {
    emit(LoadingCharactersState());
    try {
      final response = await userRepository.getAllUsers(
        event.page,
      );
      emit(DataCharactersState(networkCharacters: response));
    } catch (_) {
      emit(ErrorCharactersState());
    }
  }

  FutureOr<void> _onPagination(
      PaginationEvent event, Emitter<CharactersState> emit) async {
    final currentState = state;
    if (currentState is DataCharactersState) {
      try {
        final response = await userRepository.getAllUsers(event.pageIndex);
        emit(
          DataCharactersState(
            networkCharacters: NetworkResponse(
              info: response.info,
              results: [
                ...currentState.networkCharacters!.results,
                ...response.results
              ],
            ),
          ),
        );
      } catch (_) {
        emit(ErrorCharactersState());
      }
    }
  }

  FutureOr<void> _onFilterCharactersEvent(
      FilterCharactersEvent event, Emitter<CharactersState> emit) async {
    try {
      emit(LoadingCharactersState());
      final response = await userRepository.getCharactersByGenderAndStatus(
        aliveStatusToString(event.aliveStatus),
        genderTypeToString(event.gender),
      );
      emit(DataCharactersState(networkCharacters: response));
    } catch (e) {
      emit(ErrorCharactersState());
    }
  }
}

String genderTypeToString(GenderType? genderType) {
  if (genderType == null) return '';
  switch (genderType) {
    case GenderType.male:
      return 'male';
    case GenderType.female:
      return 'female';
  }
}

String aliveStatusToString(AliveStatusType? aliveStatusType) {
  if (aliveStatusType == null) return '';
  switch (aliveStatusType) {
    case AliveStatusType.alive:
      return 'alive';
    case AliveStatusType.dead:
      return 'dead';
  }
}
