import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty/screens/chatacter/bloc/bloc.dart';
import 'package:rick_morty/screens/chatacter/bloc/bloc_for_character_single/bloc.dart';
import 'package:rick_morty/screens/chatacter/bloc_search_name/bloc.dart';
import 'package:rick_morty/screens/chatacter/characters_screen.dart';
import 'package:rick_morty/screens/chatacter/repository/repository_characters.dart';
import 'package:rick_morty/screens/locations_screen/bloc/bloc.dart';
import 'package:rick_morty/screens/locations_screen/location_search_screen/bloc/bloc.dart';
import 'package:rick_morty/screens/locations_screen/locations_screen.dart';
import 'package:rick_morty/screens/locations_screen/repository/repository_locations.dart';
import 'package:rick_morty/splash_screen.dart';

void main() {
  runApp(MyApp());
}
// доделать локацию пагинацию
class MyApp extends StatelessWidget {
  UserRepository userRepository = UserRepository();
  LocationsRepository locationsRepository = LocationsRepository();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CharactersBloc>(
          create: (context) => CharactersBloc(userRepository),
        ),
        BlocProvider<CharacterSingleBloc>(
          create: (context) => CharacterSingleBloc(userRepository),
        ),
        BlocProvider<SearchNameBloc>(
          create: (context) => SearchNameBloc(userRepository),
        ),
        BlocProvider<LocationsBloc>(
          create: (context) => LocationsBloc(locationsRepository)
        ),
        BlocProvider<SearchLocationBloc>(create: (context) => SearchLocationBloc(locationsRepository),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:  const SplashScreen(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  final screens = [
    const CharactersScreen(),
    const LocationsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        backgroundColor: Colors.blueGrey.shade800,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Characters',
              backgroundColor: Colors.blueGrey),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              label: 'Locations',
              backgroundColor: Colors.blueGrey),
          BottomNavigationBarItem(
              icon: Icon(Icons.live_tv),
              label: 'Episodes',
              backgroundColor: Colors.blueGrey),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_suggest),
              label: 'Character',
              backgroundColor: Colors.blueGrey),
        ],
      ),
    );
  }
}
