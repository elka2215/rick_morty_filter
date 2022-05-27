import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty/screens/chatacter/bloc/bloc.dart';
import 'package:rick_morty/screens/chatacter/bloc/bloc_event.dart';

class CharacterFiltersModel extends StatefulWidget {
  const CharacterFiltersModel(
      {Key? key,
      required this.gender,
      required this.aliveStatus,
      required this.charactersBloc})
      : super(key: key);

  final GenderType? gender;
  final AliveStatusType? aliveStatus;
  final CharactersBloc charactersBloc;

  @override
  State<CharacterFiltersModel> createState() => _CharacterFiltersModelState();
}

class _CharacterFiltersModelState extends State<CharacterFiltersModel> {
  GenderType? gender;
  AliveStatusType? aliveStatus;

  @override
  void initState() {
    gender = widget.gender;
    aliveStatus = widget.aliveStatus;
    super.initState();
  }

  bool status = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CharactersBloc>.value(
      value: widget.charactersBloc,
      child: Builder(builder: (context) {
        return Column(
          children: [
            ListTile(
              title: const Text(
                'Male',
                style: TextStyle(color: Colors.white),
              ),
              leading: Radio<GenderType>(
                value: GenderType.male,
                groupValue: gender,
                onChanged: (GenderType? value) {
                  setState(() {
                    gender = value;
                  });
                  context
                      .read<CharactersBloc>()
                      .add(FilterCharactersEvent(gender: GenderType.male));
                },
              ),
            ),
            ListTile(
              title: const Text(
                'Female',
                style: TextStyle(color: Colors.white),
              ),
              leading: Radio<GenderType>(
                value: GenderType.female,
                groupValue: gender,
                onChanged: (GenderType? value) {
                  setState(() {
                    gender = value;
                  });
                  context
                      .read<CharactersBloc>()
                      .add(FilterCharactersEvent(gender: GenderType.female));
                },
              ),
            ),
            ListTile(
              title: const Text(
                'Alive',
                style: TextStyle(color: Colors.white),
              ),
              leading: Radio<AliveStatusType>(
                value: AliveStatusType.alive,
                groupValue: aliveStatus,
                onChanged: (AliveStatusType? value) {
                  setState(() {
                    aliveStatus = value;
                  });
                  context.read<CharactersBloc>().add(FilterCharactersEvent(
                      aliveStatus: AliveStatusType.alive));
                },
              ),
            ),
            ListTile(
              title: const Text(
                'Dead',
                style: TextStyle(color: Colors.white),
              ),
              leading: Radio<AliveStatusType>(
                value: AliveStatusType.dead,
                groupValue: aliveStatus,
                onChanged: (AliveStatusType? value) {
                  setState(() {
                    aliveStatus = value;
                  });
                  context.read<CharactersBloc>().add(
                      FilterCharactersEvent(aliveStatus: AliveStatusType.dead));
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}

enum GenderType { male, female }
enum AliveStatusType { alive, dead }
