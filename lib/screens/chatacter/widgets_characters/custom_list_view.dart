// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:rick_morty/domain/model/character_model.dart';
// import 'package:rick_morty/screens/chatacter/bloc/bloc.dart';
// import 'package:rick_morty/screens/chatacter/bloc/bloc_event.dart';
//
// class CustomListView extends StatefulWidget {
//   const CustomListView({Key? key}) : super(key: key);
//
//   @override
//   State<CustomListView> createState() => _CustomListViewState();
// }
//
// class _CustomListViewState extends State<CustomListView> {
//   @override
//   final RefreshController refreshController = RefreshController();
//   bool _isPagination = false;
//   int _currentPage = 1;
//   late NetworkResponse _networkResponse;
//   List<Character> _currentCharacter = [];
//
//   @override
//   void initState() {
//     context.read<CharactersBloc>().add(InitialCharactersEvent(page: 1));
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SmartRefresher(
//         controller: refreshController,
//         enablePullUp: true,
//         enablePullDown: false,
//         onLoading: () {
//           _isPagination = true;
//           _currentPage++;
//           if (_currentPage <= (_networkResponse.info.pages)) {
//             context
//                 .read<CharactersBloc>()
//                 .add(InitialCharactersEvent(page: _currentPage));
//           } else {
//             refreshController.loadNoData();
//           }
//         },
//         child: ListView.separated(
//           separatorBuilder: (_, index) => const SizedBox(
//             height: 5,
//           ),
//           shrinkWrap: true,
//           itemCount: _currentCharacter.length,
//           itemBuilder: itemBuilder,
//         ));
//   }
// }
