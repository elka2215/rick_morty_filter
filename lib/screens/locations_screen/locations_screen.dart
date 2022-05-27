import 'package:flutter/material.dart';
import 'package:rick_morty/screens/locations_screen/repository/repository_locations.dart';
import 'package:rick_morty/screens/locations_screen/widgets_locations/locations_list.dart';
import 'package:rick_morty/screens/locations_screen/location_search_screen/search_location.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({Key? key}) : super(key: key);

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  final locationsRepository = LocationsRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade800,
      body: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  SearchLocation(),
                    ),
                  );
                },
                child: TextFormField(
                  enabled: false,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                    fillColor: Colors.blueGrey,
                    filled: true,
                    hintText: 'Find Location',
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(Icons.search),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                      borderSide: BorderSide(color: Colors.black12, width: 0),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'TOTAL CHARACTERS: 826',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
          const Expanded(
            child: LocationsList(),
          ),
        ],
      ),
    );
  }
}
