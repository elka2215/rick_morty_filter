import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty/screens/locations_screen/location_search_screen/bloc/bloc_event.dart';
import 'package:rick_morty/screens/locations_screen/location_search_screen/bloc/bloc_state.dart';
import 'package:rick_morty/screens/locations_screen/repository/repository_locations.dart';
import 'package:rick_morty/screens/locations_screen/widgets_locations/location_filters_model.dart';

class SearchLocationBloc
    extends Bloc<SearchLocEventThings, SearchLocationState> {
  final LocationsRepository locationsRepository;
  LocationFilterEnum locationFilterEnum = LocationFilterEnum.name;
  SearchLocationBloc(this.locationsRepository)
      : super(SearchErrorLocationState()) {
    on<SearchLocEventThings>(_onSearchLocEventThings);
  }

  FutureOr<void> _onSearchLocEventThings(SearchLocEventThings event,
      Emitter<SearchLocationState> emit) async {
    try {
      emit(SearchLoadingLocationState());
      final response = await locationsRepository.getFiltersLocation(event.locationFilterEnumEvent, locationFilterEnumToString(locationFilterEnum));
      emit(SearchLoadedLocationState(locationsModel: response));
    } catch (e) {
      emit(SearchErrorLocationState());
    }
  }
}

String locationFilterEnumToString(LocationFilterEnum? locationFilterEnum) {
  if (locationFilterEnum == null) return '';
  switch (locationFilterEnum) {
    case LocationFilterEnum.name:
      return 'name';
    case (LocationFilterEnum.type):
      return 'type';
    case (LocationFilterEnum.dimension):
      return 'dimension';
  }return '';
}
