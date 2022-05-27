import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty/domain/model/locations_model.dart';
import 'package:rick_morty/screens/locations_screen/bloc/bloc_event.dart';
import 'package:rick_morty/screens/locations_screen/bloc/states_bloc.dart';
import 'package:rick_morty/screens/locations_screen/repository/repository_locations.dart';

class LocationsBloc extends Bloc<LocationsEvent, LocationsStates> {
  final LocationsRepository locationsRepository;

  LocationsBloc(this.locationsRepository) : super(LocationsEmptyStates()) {
    on<LocationsLoadEvent>(_onLocationsLoadEvent);
    // on<LocationsFilterEvent>(_onLocationsFilterEvent);
    on<PaginationLocEvent>(_onPaginationLocationEvent);
  }

  FutureOr<void> _onLocationsLoadEvent(
      LocationsLoadEvent event, Emitter<LocationsStates> emit) async {
    emit(LocationsLoadingStates(isFirstFetch: false));
    try {
      final response = await locationsRepository.getAllLocations(event.page);
      emit(LocationsDataStates(locationsLoaded: response));
    } catch (_) {
      emit(LocationsErrorStates());
    }
  }

  FutureOr<void> _onPaginationLocationEvent(
      PaginationLocEvent event, Emitter<LocationsStates> emit) async {
    final currentStateLoc = state;
    if (currentStateLoc is LocationsDataStates) {
      try {
        final response =
            await locationsRepository.getAllLocations(event.pageIndex);
        emit(
          LocationsDataStates(
            locationsLoaded: LocationsModel(
              info: response.info,
              results: [
                ...currentStateLoc.locationsLoaded.results,
                ...response.results
              ],
            ),
          ),
        );
      } catch (_) {
        emit(LocationsErrorStates());
      }
    }
  }

//   FutureOr<void> _onLocationsFilterEvent(
//       LocationsFilterEvent event, Emitter<LocationsStates> emit) async {
//     try {
//       emit(LocationsLoadingStates());
//       final response = await locationsRepository.getFiltersLocation(
//           event.locationEnum, event.find);
//       emit(LocationsDataStates(locationsLoaded: response));
//     } catch (_) {}
//   }
// }

// String locationFilterToString(LocationName? locationEnum) {
//   if (locationEnum == null) return '';
//   switch (locationEnum) {
//     case LocationName.name:
//       return 'name';
//     case LocationName.type:
//       return 'type';
//     case LocationName.dimension:
//       return 'dimension';
//   }
}
