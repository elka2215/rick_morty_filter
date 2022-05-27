import 'package:rick_morty/screens/chatacter/widgets_characters/show_modal_filters.dart';

abstract class CharactersEvent {}

class InitialCharactersEvent extends CharactersEvent {
  int page;

  InitialCharactersEvent({required this.page});
}

class PaginationEvent extends CharactersEvent {
  int pageIndex;

  PaginationEvent({required this.pageIndex});
}

class FilterCharactersEvent extends CharactersEvent {
  final GenderType? gender;
  final AliveStatusType? aliveStatus;

  FilterCharactersEvent({this.gender, this.aliveStatus});
}
