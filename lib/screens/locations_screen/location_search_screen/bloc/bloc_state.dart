import 'package:rick_morty/domain/model/locations_model.dart';
import 'package:rick_morty/screens/locations_screen/widgets_locations/location_filters_model.dart';

abstract class SearchLocationState{}

class SearchEmptyLocationState extends SearchLocationState{}
class SearchLoadingLocationState extends SearchLocationState{}
class SearchLoadedLocationState extends SearchLocationState{

  LocationsModel? locationsModel;
  SearchLoadedLocationState({this.locationsModel});
}
class SearchErrorLocationState extends SearchLocationState{}