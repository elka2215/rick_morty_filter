abstract class CharacterSingleEvent{}


class LoadCharacterSingleEvent extends CharacterSingleEvent{
  final int id;

  LoadCharacterSingleEvent({required this.id});
}

