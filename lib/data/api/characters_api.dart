import 'package:dio/dio.dart';
import 'package:rick_morty/domain/model/character_model.dart';

class CharacterApi {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: 'https://rickandmortyapi.com/api'),
  );

  Future<NetworkResponse> getCharactersAll({required int page}) async {
    try {
      final response = await _dio.get('/character', queryParameters: {'page': page}); // Изменил параментры
      return NetworkResponse.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }

  Future<NetworkResponse> getCharactersByGenderAndStatus(
      {String? status, String? gender}) async {
    try {
      final response = await _dio.get('/character', queryParameters: {
        'status': status,
        'gender': gender,
      });
      return NetworkResponse.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }

  Future<NetworkResponse> getSearchNameApi({String? name}) async{
    try{
      final response = await _dio.get('/character', queryParameters: {'name' : name});
      return NetworkResponse.fromJson(response.data);
    }catch(error){
      rethrow;
    }
  }

  Future<Character> getCharacterByIdApi({int? id}) async {
    try {
      final response = await _dio.get('/character/$id');
      return Character.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }
}
