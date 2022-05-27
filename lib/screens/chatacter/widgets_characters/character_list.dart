import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rick_morty/screens/chatacter/bloc/bloc_event.dart';
import 'package:rick_morty/screens/chatacter/characters_person.dart';
import 'package:rick_morty/screens/chatacter/bloc/bloc.dart';
import 'package:rick_morty/screens/chatacter/bloc/bloc_for_character_single/bloc.dart';
import 'package:rick_morty/screens/chatacter/bloc/bloc_for_character_single/bloc_event.dart';
import 'package:rick_morty/screens/chatacter/bloc/bloc_state.dart';

class CharacterList extends StatefulWidget {
  const CharacterList({Key? key}) : super(key: key);

  @override
  State<CharacterList> createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList> {
  final RefreshController refreshController = RefreshController();
  bool _isPagination = false;
  int _currentPage = 1;

  @override
  void initState() {
    context.read<CharactersBloc>().add(InitialCharactersEvent(page: 1));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharactersBloc, CharactersState>(
        builder: (context, state) {
      if (state is EmptyCharactersState) {
        return const Center(
          child: Text('empty'),
        );
      }
      if (state is LoadingCharactersState) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is DataCharactersState) {
        if (_isPagination) {
          refreshController.loadComplete();
          _isPagination = false;
        }
        return SmartRefresher(
          controller: refreshController,
          enablePullUp: true,
          enablePullDown: false,
          onLoading: () {
            _isPagination = true;
            _currentPage++;
            if (_currentPage < (state.networkCharacters!.info.pages)) {
              context
                  .read<CharactersBloc>()
                  .add(PaginationEvent(pageIndex: _currentPage));
            } else {
              refreshController.loadNoData();
            }
          },
          child: ListView.builder(
            itemCount: state.networkCharacters?.results.length,
            itemBuilder: (BuildContext ctx, index) {
              return InkWell(
                onTap: () {
                  context.read<CharacterSingleBloc>().add(
                      LoadCharacterSingleEvent(
                          id: state.networkCharacters!.results[index].id!));
                  Route route = MaterialPageRoute(
                      builder: (context) => const CharactersPerson());
                  Navigator.push(ctx, route);
                },
                child: ListTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${state.networkCharacters?.results[index].status}',
                        style: const TextStyle(color: Colors.greenAccent),
                      ),
                      Text(
                        state.networkCharacters?.results[index].name ?? '',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        '${state.networkCharacters?.results[index].gender}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  leading: SizedBox(
                    width: 70,
                    child: Center(
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            state.networkCharacters?.results[index].image ??
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
      if (state is ErrorCharactersState) {
        return const Center(
          child: Text('error'),
        );
      }
      return const SizedBox.shrink();
    });
  }
}
