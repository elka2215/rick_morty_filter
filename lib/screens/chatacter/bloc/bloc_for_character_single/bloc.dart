import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty/screens/chatacter/bloc/bloc_for_character_single/bloc_event.dart';
import 'package:rick_morty/screens/chatacter/bloc/bloc_for_character_single/bloc_state.dart';
import 'package:rick_morty/screens/chatacter/repository/repository_characters.dart';

class CharacterSingleBloc extends Bloc<CharacterSingleEvent, CharacterSingleState>{
  final UserRepository userRepository;
  CharacterSingleBloc(this.userRepository) : super(EmptyCharacterSingle()){
   on<LoadCharacterSingleEvent>(_onLoadCharacterSingleEvent);
  }

  FutureOr<void> _onLoadCharacterSingleEvent(
      LoadCharacterSingleEvent event, Emitter<CharacterSingleState> emit) async{
    try{
      final response = await userRepository.getCharacterById(event.id);
      emit(SuccessDataCharacterSingle(character: response));
    }catch(e){
      emit(ErrorCharacterSingleState(e));
    }
  }
}