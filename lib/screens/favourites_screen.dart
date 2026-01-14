import 'package:flutter/material.dart';
import 'package:hockey_app/widgets/fav_team_item_list.dart';

class FavouritesScreen extends StatefulWidget {
  final List<String> teams;
  const FavouritesScreen({super.key, required this.teams});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mis Equipos')),
      body: FavTeamItemList(teams: widget.teams),
      backgroundColor: Color.fromRGBO(145, 155, 160, 1),
    );
  }
}
