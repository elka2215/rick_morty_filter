import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty/screens/chatacter/bloc/bloc_for_character_single/bloc.dart';
import 'package:rick_morty/screens/chatacter/bloc/bloc_for_character_single/bloc_event.dart';
import 'package:rick_morty/screens/chatacter/bloc_search_name/bloc.dart';
import 'package:rick_morty/screens/chatacter/bloc_search_name/bloc_event.dart';
import 'package:rick_morty/screens/chatacter/bloc_search_name/bloc_state.dart';
import 'package:rick_morty/screens/chatacter/characters_person.dart';
import 'package:rick_morty/screens/chatacter/characters_screen.dart';

class SearchCharacters extends StatelessWidget {
  SearchCharacters({Key? key, this.searchDebounce}) : super(key: key);

  Timer? searchDebounce;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Form(
              child: TextFormField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Find Character',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CharactersScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                    borderSide: BorderSide(color: Colors.black12, width: 0),
                  ),
                ),
                onChanged: (value) {
                  searchDebounce = Timer(const Duration(seconds: 1), (){
                    context
                        .read<SearchNameBloc>()
                        .add(SearchNameEvent(name: value));
                  });

                },
              ),
            ),
            BlocBuilder<SearchNameBloc, SearchCharactersState>(
              builder: (context, state) {
                if (state is EmptySearchNameState) {
                  return const Center(
                    child: Text('Empty'),
                  );
                }
                if (state is LoadingSearchNameState) {
                  return const Center(
                    child: SizedBox(
                      height: 50,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'P.S. Write character for Name',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                }
                if (state is SearchNameCharactersState) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.networkResponse?.results.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            context.read<CharacterSingleBloc>().add(
                                LoadCharacterSingleEvent(
                                    id: state
                                        .networkResponse!.results[index].id!));
                            Route route = MaterialPageRoute(
                                builder: (context) => const CharactersPerson());
                            Navigator.push(context, route);
                          },
                          child: ListTile(
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${state.networkResponse?.results[index].status}',
                                  style:
                                      const TextStyle(color: Colors.greenAccent),
                                ),
                                Text(
                                  state.networkResponse?.results[index].name ??
                                      '',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                Text(
                                  '${state.networkResponse?.results[index].gender}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            leading: SizedBox(
                              width: 70,
                              child: Center(
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(state
                                          .networkResponse
                                          ?.results[index]
                                          .image ??
                                      ''),
                                  maxRadius: 36,
                                  minRadius: 12,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
