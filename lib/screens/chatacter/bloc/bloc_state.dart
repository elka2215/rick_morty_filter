import 'package:rick_morty/domain/model/character_model.dart';
import 'package:rick_morty/screens/chatacter/widgets_characters/show_modal_filters.dart';

abstract class CharactersState {}

class EmptyCharactersState extends CharactersState {}

class LoadingCharactersState extends CharactersState {}

class LoadingCharactersPaginationState extends CharactersState {}

class DataCharactersState extends CharactersState {
  GenderType? gender;
  AliveStatusType? aliveStatus;
  NetworkResponse? networkCharacters;
  Character? character;

  DataCharactersState(
      {this.networkCharacters, this.aliveStatus, this.gender, this.character});
}

class SearchNameState extends CharactersState {}

class OnPaginationState extends CharactersState {}

class ErrorCharactersState extends CharactersState {}
