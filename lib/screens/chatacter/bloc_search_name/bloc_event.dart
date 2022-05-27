  abstract class SearchNameCharacter{}

  class SearchNameEvent extends SearchNameCharacter{
    String? name;

    SearchNameEvent({this.name});
  }