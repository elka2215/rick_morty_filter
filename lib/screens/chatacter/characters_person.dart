import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty/screens/chatacter/bloc/bloc_for_character_single/bloc.dart';
import 'package:rick_morty/screens/chatacter/bloc/bloc_for_character_single/bloc_state.dart';

class CharactersPerson extends StatefulWidget {
  const CharactersPerson({Key? key}) : super(key: key);

  @override
  State<CharactersPerson> createState() => _CharactersPersonState();
}

class _CharactersPersonState extends State<CharactersPerson> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterSingleBloc, CharacterSingleState>(
      builder: (context, state) {
        if (state is SuccessDataCharacterSingle) {
          return Scaffold(
            backgroundColor: Colors.blueGrey,
            body: SingleChildScrollView(
              controller: scrollController,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Image.network(state.character.image ?? ''),
                    ),
                    Text(
                      state.character.name ?? '',
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                    Text(
                      state.character.status ?? '',
                      style: TextStyle(color: Colors.greenAccent, fontSize: 16),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Gender'),
                            Text(
                              state.character.gender ?? '',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Race'),
                            Text(
                              state.character.species ?? '',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Origin Location'),
                            Text(
                              state.character.origin?.name ?? '',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Locaton'),
                            Text(state.character.location?.name ?? '',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Align(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          'Episodes',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      controller: scrollController,
                      itemCount: state.character.episode?.length,
                      itemBuilder: (BuildContext context, index) {
                        return ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.character.episode?[index] ?? '',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Text(
                                DateTime.parse(
                                  state.character.created ?? '',
                                ).toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                          leading: Image.network(
                              'https://bipbap.ru/wp-content/uploads/2019/08/kosmos-106-800x800.jpg'),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        if (state is ErrorCharacterSingleState) {
          return Scaffold(
            body: Center(
              child: Text(state.error.toString()),
            ),
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

class CharacterSingleEpisodes extends StatelessWidget {
  const CharacterSingleEpisodes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
