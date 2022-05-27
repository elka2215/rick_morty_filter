import 'package:rick_morty/data/api/characters_api.dart';
import 'package:rick_morty/domain/model/character_model.dart';

class UserRepository {
  final CharacterApi _characterApi = CharacterApi();

  Future<NetworkResponse> getAllUsers(int page) =>
      _characterApi.getCharactersAll(page: page);

  Future<Character> getCharacterById(int id) =>
      _characterApi.getCharacterByIdApi(id: id);

  Future<NetworkResponse> getSearchName(String? name) =>
      _characterApi.getSearchNameApi(name: name);

  Future<NetworkResponse> getCharactersByGenderAndStatus(
          String status, String gender) =>
      _characterApi.getCharactersByGenderAndStatus(
          status: status, gender: gender);
}
