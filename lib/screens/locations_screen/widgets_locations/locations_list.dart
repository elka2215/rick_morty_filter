import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rick_morty/screens/locations_screen/bloc/bloc.dart';
import 'package:rick_morty/screens/locations_screen/bloc/bloc_event.dart';
import 'package:rick_morty/screens/locations_screen/bloc/states_bloc.dart';

class LocationsList extends StatefulWidget {
  const LocationsList({Key? key}) : super(key: key);

  @override
  State<LocationsList> createState() => _LocationsListState();
}

class _LocationsListState extends State<LocationsList> {
  final RefreshController _refreshController = RefreshController();
  int _currentPage = 1;
  bool _isPagination = false;

  @override
  void initState() {
    context.read<LocationsBloc>().add(
          LocationsLoadEvent(page: 1),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationsBloc, LocationsStates>(
        builder: (context, state) {
      if (state is LocationsEmptyStates) {
        return const Center(
          child: Text('empty'),
        );
      }
      if (state is LocationsLoadingStates) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is LocationsDataStates) {
        if (_isPagination) {
          _refreshController.loadComplete();
          _isPagination = false;
        }
        return SmartRefresher(
          controller: _refreshController,
          enablePullUp: true,
          enablePullDown: false,
          onLoading: () {
            _isPagination = true;
            _currentPage++;
            if (_currentPage < (state.locationsLoaded.info.pages)) {
              context.read<LocationsBloc>().add(
                    PaginationLocEvent(pageIndex: _currentPage),
                  );
            } else {
              _refreshController.loadNoData();
            }
          },
          child: ListView.builder(
            itemCount: state.locationsLoaded.results.length,
            itemBuilder: (BuildContext context, index) {
              return ListTile(
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.locationsLoaded.results[index].name,
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      '${state.locationsLoaded.results[index].type} - ${state.locationsLoaded.results[index].dimension}',
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

      if (state is LocationsErrorStates) {
        return const Center(
          child: Text('error'),
        );
      }
      return const SizedBox.shrink();
    });
  }
}
