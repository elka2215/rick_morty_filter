import 'package:rick_morty/domain/model/character_model.dart';

abstract class CharacterSingleState {}
class EmptyCharacterSingle extends CharacterSingleState{}
class SuccessDataCharacterSingle extends CharacterSingleState{
  final Character character;

  SuccessDataCharacterSingle({required this.character});
}
class ErrorCharacterSingleState extends CharacterSingleState{
  Object error;

  ErrorCharacterSingleState(this.error);
}