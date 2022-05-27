import 'package:rick_morty/domain/model/character_model.dart';

abstract class SearchCharactersState{}

class EmptySearchNameState extends SearchCharactersState {}

class LoadingSearchNameState extends SearchCharactersState {}

class SearchNameCharactersState extends SearchCharactersState{

  NetworkResponse? networkResponse;
  SearchNameCharactersState({this.networkResponse});
}

class ErrorSearchNameState extends SearchCharactersState {}
