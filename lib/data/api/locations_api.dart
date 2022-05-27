import 'package:dio/dio.dart';
import 'package:rick_morty/domain/model/locations_model.dart';

class LocationsApi {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://rickandmortyapi.com/api',
    ),
  );

  Future<LocationsModel> getAllLocations({required int page}) async {
    try {
      final response = await _dio.get(
        '/location',
        queryParameters: {'page': page},
      );
      return LocationsModel.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }

  Future<LocationsModel> getFilterLocation({required String locationFilterEnum, required String type}) async {
    try {
      final response = await _dio.get('/location', queryParameters: {type : locationFilterEnum,});
      return LocationsModel.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }
}
