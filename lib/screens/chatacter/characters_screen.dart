import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty/screens/chatacter/bloc/bloc.dart';
import 'package:rick_morty/screens/chatacter/bloc/bloc_state.dart';
import 'package:rick_morty/screens/chatacter/search_characters.dart';
import 'package:rick_morty/screens/chatacter/widgets_characters/show_modal_filters.dart';
import 'package:rick_morty/screens/chatacter/widgets_characters/character_list.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade800,
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              child: TextFormField(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchCharacters(),
                    ),
                  );
                },
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  fillColor: Colors.blueGrey,
                  filled: true,
                  hintText: 'Find Character',
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
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'TOTAL CHARACTERS: 826',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontStyle: FontStyle.italic),
                ),
                BlocBuilder<CharactersBloc, CharactersState>(
                  builder: (BuildContext context, CharactersState state) {
                    if (state is DataCharactersState) {
                      return IconButton(
                        icon: const Icon(Icons.list),
                        color: Colors.white,
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext ctx) {
                              return Container(
                                height: 250,
                                color: Colors.blueGrey,
                                child: CharacterFiltersModel(
                                    gender: state.gender,
                                    aliveStatus: state.aliveStatus,
                                    charactersBloc:
                                        context.watch<CharactersBloc>()),
                              );
                            },
                          );
                        },
                      );
                    }
                    return const SizedBox(
                      width: 20,
                      height: 20,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const Expanded(
            child: CharacterList(),
          ),
        ],
      ),
    );
  }
}
