abstract class CharacterSingleListEvent{}

class LoadCharacterSingleListEvent extends CharacterSingleListEvent{
  final int id;

  LoadCharacterSingleListEvent({required this.id});
}