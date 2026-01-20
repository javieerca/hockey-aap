import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hockey_app/models/team.dart';
import 'package:hockey_app/services/firestore_service.dart';

class FavTeamItemList extends StatelessWidget {
  const FavTeamItemList({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final FirestoreService firestoreService = FirestoreService();

    return StreamBuilder<List<Team>>(
      stream: firestoreService.getTeamsStream(uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text("Error al cargar equipos"));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No hay equipos favoritos."));
        }

        final teams = snapshot.data!;

        return Column(
          children: [
            ListView.builder(
              padding: const EdgeInsets.all(8),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: teams.length,
              // reverse: true, // Assuming default order is preferred or handled by stream
              itemBuilder: (context, index) {
                return ItemTeam(team: teams[index]);
              },
            ),
          ],
        );
      },
    );
  }
}

class ItemTeam extends StatelessWidget {
  const ItemTeam({super.key, required this.team});

  final Team team;

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    if (team.isFavorite) {
      return Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Icon(Icons.shield, size: 64),
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(team.name, style: TextStyle(fontSize: 24)),
                  Text(team.federacion),
                  Text(team.liga),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.star, color: Colors.amber),
              onPressed: () async {
                //todo implementar marcar favorito
              },
            ),

            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                await FirestoreService().removeTeam(uid, team.id);
              },
            ),
          ],
        ),
      );
    }

    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Icon(Icons.shield, size: 64),
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(team.name, style: TextStyle(fontSize: 24)),
                Text(team.federacion),
                Text(team.liga),
              ],
            ),
          ),

          IconButton(
            icon: const Icon(Icons.star_border),
            onPressed: () async {
              //todo implementar marcar favorito
              changeFavTeam(uid, team.id);
            },
          ),

          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () async {
              await FirestoreService().removeTeam(uid, team.id);
            },
          ),
        ],
      ),
    );
  }

  Future<void> changeFavTeam(String uid, String newTeamId) async {
    //encontrar favorito
    final favTeamId = await FirestoreService().getFavTeamId(uid);
    await FirestoreService().unmarkFavorite(uid, favTeamId);
    await FirestoreService().markFavorite(uid, newTeamId);
  }
}
