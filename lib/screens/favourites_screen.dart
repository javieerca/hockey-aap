import 'package:flutter/material.dart';
import 'package:hockey_app/models/team.dart';
import 'package:hockey_app/services/auth_service.dart';
import 'package:hockey_app/services/firestore_service.dart';
import 'package:hockey_app/widgets/appbar/appbar_items.dart';
import 'package:hockey_app/widgets/fav_team_item_list.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppbarText(text: 'Mis Equipos'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(145, 155, 160, 1),
      ),

      // bottomNavigationBar: MyNavBar(),
      body: ListView(
        children: [
          FavTeamItemList(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: () {
                uploadHockeyTeams();
              },
              child: const Text('Añadir equipos'),
            ),
          ),
        ],
      ),
      backgroundColor: Color.fromRGBO(145, 155, 160, 1),
    );
  }

  Future<void> uploadHockeyTeams() async {
    final FirestoreService db = FirestoreService();
    final AuthService authService = AuthService();
    // 1. Creamos el Batch (lote de escritura)

    // 2. Definimos la lista de 10 equipos
    // Nota: Dejo 'isSelected' en false por defecto
    List<Team> teams = [
      Team(
        id: 'team_01',
        name: 'Barça',
        isSelected: false,
        federacion: 'RFEP',
        liga: 'OK Liga',
      ),
      Team(
        id: 'team_02',
        name: 'Deportivo Liceo',
        isSelected: false,
        federacion: 'RFEP',
        liga: 'OK Liga',
      ),
      Team(
        id: 'team_03',
        name: 'Reus Deportiu',
        isSelected: false,
        federacion: 'RFEP',
        liga: 'OK Liga',
      ),
      Team(
        id: 'team_04',
        name: 'CE Noia',
        isSelected: false,
        federacion: 'RFEP',
        liga: 'OK Liga',
      ),
      Team(
        id: 'team_05',
        name: 'Igualada HC',
        isSelected: false,
        federacion: 'RFEP',
        liga: 'OK Liga',
      ),
      Team(
        id: 'team_06',
        name: 'FC Porto',
        isSelected: false,
        federacion: 'FPP',
        liga: '1ª Divisão',
      ),
      Team(
        id: 'team_07',
        name: 'SL Benfica',
        isSelected: false,
        federacion: 'FPP',
        liga: '1ª Divisão',
      ),
      Team(
        id: 'team_08',
        name: 'Sporting CP',
        isSelected: false,
        federacion: 'FPP',
        liga: '1ª Divisão',
      ),
      Team(
        id: 'team_09',
        name: 'UD Oliveirense',
        isSelected: false,
        federacion: 'FPP',
        liga: '1ª Divisão',
      ),
      Team(
        id: 'team_10',
        name: 'OC Barcelos',
        isSelected: false,
        federacion: 'FPP',
        liga: '1ª Divisão',
      ),
    ];

    db.addTeams(authService.currentUser!.uid, teams);
    // 3. Preparamos las operaciones
  }
}
