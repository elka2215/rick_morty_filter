import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rick_morty/screens/locations_screen/location_search_screen/bloc/bloc_event.dart';

import '../location_search_screen/bloc/bloc.dart';

class LocationFiltersModel extends StatefulWidget {
  const LocationFiltersModel(
      {Key? key, required this.locationFilterEnum, required this.searchLocationBloc})
      : super(key: key);
  final LocationFilterEnum? locationFilterEnum;
  final SearchLocationBloc searchLocationBloc;

  @override
  State<LocationFiltersModel> createState() => _LocationFiltersModelState();
}

class _LocationFiltersModelState extends State<LocationFiltersModel> {
  LocationFilterEnum? locationEnum;

  @override
  void initState() {
    locationEnum = widget.locationFilterEnum;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchLocationBloc>.value(
      value: widget.searchLocationBloc,
      child: Builder(
        builder: (context) {
          return Column(
            children: [
              ListTile(
                title: const Text('Name'),
                leading: Radio<LocationFilterEnum>(
                  value: LocationFilterEnum.name,
                  groupValue: locationEnum,
                  onChanged: (LocationFilterEnum? value) {
                    setState(() {
                      locationEnum = value;
                    });
                    context.read<SearchLocationBloc>().locationFilterEnum = LocationFilterEnum.name;
                  },
                ),
              ),
              ListTile(
                title: const Text('Type'),
                leading: Radio<LocationFilterEnum>(
                  value: LocationFilterEnum.type,
                  groupValue: locationEnum,
                  onChanged: (LocationFilterEnum? value) {
                    setState(() {
                      locationEnum = value;
                    });
                    context.read<SearchLocationBloc>().locationFilterEnum = LocationFilterEnum.type;
                  },
                ),
              ),
              ListTile(
                title: const Text('Dimension'),
                leading: Radio<LocationFilterEnum>(
                  value: LocationFilterEnum.dimension,
                  groupValue: locationEnum,
                  onChanged: (LocationFilterEnum? value) {
                    setState(() {
                      locationEnum = value;
                    });
                    context.read<SearchLocationBloc>().locationFilterEnum = LocationFilterEnum.dimension;
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

enum LocationFilterEnum { name , type, dimension }
