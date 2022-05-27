import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty/screens/locations_screen/location_search_screen/bloc/bloc.dart';
import 'package:rick_morty/screens/locations_screen/location_search_screen/bloc/bloc_event.dart';
import 'package:rick_morty/screens/locations_screen/location_search_screen/bloc/bloc_state.dart';

import '../widgets_locations/location_filters_model.dart';

class SearchLocation extends StatelessWidget {
  SearchLocation({Key? key, this.searchDebounce}) : super(key: key);
  Timer? searchDebounce;
  var valueName = describeEnum(LocationFilterEnum.name);
  var valueType = describeEnum(LocationFilterEnum.type);
  var valueDimension = describeEnum(LocationFilterEnum.dimension);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade800,
      body: Column(
        children: [
          const SizedBox(
            height: 35,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                fillColor: Colors.blueGrey,
                filled: true,
                hintText: 'Find Location',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.list),
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext ctx) {
                        return Container(
                          height: 200,
                          color: Colors.blueGrey,
                          child: LocationFiltersModel(
                            searchLocationBloc:
                                context.watch<SearchLocationBloc>(),
                            locationFilterEnum: context
                                .read<SearchLocationBloc>()
                                .locationFilterEnum,
                          ),
                        );
                      },
                    );
                  },
                ),
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Icon(Icons.search),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                  borderSide: BorderSide(color: Colors.black12, width: 0),
                ),
              ),
              onChanged: (value) {
                searchDebounce = Timer(const Duration(seconds: 1), () {
                  context.read<SearchLocationBloc>().add(SearchLocEventThings(
                      locationFilterEnumEvent:
                          value));
                });
              },
            ),
          ),
          BlocBuilder<SearchLocationBloc, SearchLocationState>(
            builder: (context, state) {
              if (state is SearchEmptyLocationState) {
                return const Center(
                  child: Text('empty'),
                );
              }
              if (state is SearchLoadingLocationState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is SearchLoadedLocationState) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.locationsModel?.results.length,
                    itemBuilder: (BuildContext context, index) {
                      return ListTile(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.locationsModel!.results[index].name,
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              '${state.locationsModel?.results[index].type} - ${state.locationsModel?.results[index].dimension}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        leading: Image.network(
                            'https://bipbap.ru/wp-content/uploads/2019/08/kosmos-106-800x800.jpg'),
                      );
                    },
                  ),
                );
              }
              if (state is SearchErrorLocationState) {
                return const Center(
                  child: Text('error'),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
