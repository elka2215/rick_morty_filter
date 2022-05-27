import 'package:rick_morty/domain/model/locations_model.dart';
import 'package:rick_morty/screens/locations_screen/widgets_locations/location_filters_model.dart';

abstract class LocationsStates {}

class LocationsEmptyStates extends LocationsStates {}

class LocationsLoadingStates extends LocationsStates {
  LocationsModel? oldLocationsLoaded;
  final bool isFirstFetch;

  LocationsLoadingStates({this.oldLocationsLoaded, this.isFirstFetch = false});
}

class LocationsDataStates extends LocationsStates {
  LocationFilterEnum? locationEnum;
  LocationsModel locationsLoaded;

  LocationsDataStates({required this.locationsLoaded, this.locationEnum});
}

class LocationsErrorStates extends LocationsStates {}
