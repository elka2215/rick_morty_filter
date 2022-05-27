import 'dart:async';

import 'package:rick_morty/data/api/locations_api.dart';
import 'package:rick_morty/domain/model/locations_model.dart';

import '../widgets_locations/location_filters_model.dart';

class LocationsRepository {
  final LocationsApi _locationsApi = LocationsApi();

  Future<LocationsModel> getAllLocations(int page) => _locationsApi.getAllLocations(page: page);

  Future<LocationsModel> getFiltersLocation(String locationFilterEnum, String type ) => _locationsApi.getFilterLocation(locationFilterEnum: locationFilterEnum, type: type );
}