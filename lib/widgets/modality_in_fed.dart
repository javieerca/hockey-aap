import 'package:flutter/material.dart';
import 'package:hockey_app/models/league.dart';
import 'package:hockey_app/widgets/league_in_fed_item.dart';

class ModalityInFed extends StatelessWidget {
  const ModalityInFed({super.key, required this.ligas});

  final List<League> ligas;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      backgroundColor: Colors.white,
      subtitle: Text("${ligas.length} ligas"),
      tilePadding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      iconColor: Colors.black,
      collapsedIconColor: Colors.white,
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      textColor: Colors.black,
      collapsedTextColor: Colors.white,
      title: Text(
        "Hockey patines",
        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
      ),
      children: [
        Divider(),
        for (var league in ligas) LeagueInFedItem(league: league),
      ],
    );
  }
}
