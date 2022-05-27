import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty/screens/chatacter/bloc_search_name/bloc_event.dart';
import 'package:rick_morty/screens/chatacter/bloc_search_name/bloc_state.dart';
import 'package:rick_morty/screens/chatacter/repository/repository_characters.dart';

class SearchNameBloc extends Bloc<SearchNameEvent, SearchCharactersState> {
  final UserRepository userRepository;

  SearchNameBloc(this.userRepository) : super(LoadingSearchNameState()) {
    on<SearchNameEvent>(_onSearchNameEvent);
  }

  FutureOr<void> _onSearchNameEvent(
      SearchNameEvent event, Emitter<SearchCharactersState> emit) async {
    try {
      emit(LoadingSearchNameState());
      final response = await userRepository.getSearchName(event.name);
      emit(SearchNameCharactersState(networkResponse: response));
    } catch (e) {
      emit(ErrorSearchNameState());
    }
  }
}
