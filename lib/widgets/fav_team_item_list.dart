import 'package:flutter/material.dart';

class FavTeamItemList extends StatelessWidget {
  final List<String> teams;

  const FavTeamItemList({super.key, required this.teams});

  @override
  Widget build(BuildContext context) {
    if (teams.isEmpty) {
      return const Center(child: Text("No hay equipos favoritos."));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      shrinkWrap: true,
      itemCount: teams.length,
      reverse: true,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: const Icon(Icons.shield),
            title: Text(teams[index]),
            trailing: const Icon(Icons.delete),
            onTap: () {
              //añadir logica para eliminar equipo favorito
            },
          ),
        );
      },
    );
  }
}
