import 'package:rick_morty/screens/locations_screen/widgets_locations/location_filters_model.dart';

abstract class LocationsEvent {}

class LocationsLoadEvent extends LocationsEvent {
  int page;
  LocationsLoadEvent({required this.page});
}

class PaginationLocEvent extends LocationsEvent{
  int pageIndex;
  PaginationLocEvent ({required this.pageIndex});
}

// class LocationsFilterEvent extends LocationsEvent {
//   final LocationFilterEnum locationEnum;
//   final String find;
//
//   LocationsFilterEvent(this.locationEnum, this.find);
// }

