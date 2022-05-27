import 'package:rick_morty/screens/locations_screen/widgets_locations/location_filters_model.dart';

abstract class SearchLocationEvent {}

class SearchLocEventThings {
  final String locationFilterEnumEvent;


  SearchLocEventThings({required this.locationFilterEnumEvent});
}
