import 'package:flutter/material.dart';
import 'package:hockey_app/models/team.dart';
import 'package:hockey_app/services/api_service.dart';
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
  final TextEditingController _testController = TextEditingController();

  @override
  void dispose() {
    _testController.dispose();
    super.dispose();
  }

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

          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: FloatingActionButton(
          //     onPressed: () {
          //       uploadHockeyTeams();
          //     },
          //     child: const Text('Añadir equipos'),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InputChip(
              onPressed: () {
                // Placeholder
              },
              label: const Text('Añadir equipos'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _testController,
              decoration: const InputDecoration(
                labelText: 'Simula seleccionar un equipo',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: ElevatedButton(
              onPressed: () async {
                //busca el equipo por id y lo añade a siguiendo
                final team = await getTeamById(_testController.text);
                await addFollowingTeam(team);
              },
              child: const Text('Iniciar Acción'),
            ),
          ),
        ],
      ),
      backgroundColor: Color.fromRGBO(145, 155, 160, 1),
    );
  }

  Future<Team> getTeamById(String id) async {
    final ApiService apiService = ApiService();
    final team = await apiService.getTeamById(id);
    return team;
  }

  Future<void> addFollowingTeam(Team team) async {
    final db = FirestoreService();
    await db.addTeam(team);
  }

  Future<void> uploadHockeyTeams() async {
    final db = FirestoreService();
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
        isFavorite: true,
        logo:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/FC_Barcelona_logo.svg/1200px-FC_Barcelona_logo.svg.png',
        clubId: 'team_01',
        siglas: 'FCB',
      ),
      Team(
        id: 'team_02',
        name: 'Deportivo Liceo',
        isSelected: false,
        federacion: 'RFEP',
        liga: 'OK Liga',
        isFavorite: false,
        logo:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/FC_Barcelona_logo.svg/1200px-FC_Barcelona_logo.svg.png',
        clubId: 'team_02',
        siglas: 'DLC',
      ),
      Team(
        id: 'team_03',
        name: 'Reus Deportiu',
        isSelected: false,
        federacion: 'RFEP',
        liga: 'OK Liga',
        isFavorite: false,
        logo:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/FC_Barcelona_logo.svg/1200px-FC_Barcelona_logo.svg.png',
        clubId: 'team_03',
        siglas: 'RDI',
      ),
      Team(
        id: 'team_04',
        name: 'CE Noia',
        isSelected: false,
        federacion: 'RFEP',
        liga: 'OK Liga',
        isFavorite: false,
        logo:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/FC_Barcelona_logo.svg/1200px-FC_Barcelona_logo.svg.png',
        clubId: 'team_04',
        siglas: 'CEN',
      ),
      Team(
        id: 'team_05',
        name: 'Igualada HC',
        isSelected: false,
        federacion: 'RFEP',
        liga: 'OK Liga',
        isFavorite: false,
        logo:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/FC_Barcelona_logo.svg/1200px-FC_Barcelona_logo.svg.png',
        clubId: 'team_05',
        siglas: 'IGH',
      ),
      Team(
        id: 'team_06',
        name: 'FC Porto',
        isSelected: false,
        federacion: 'FPP',
        liga: '1ª Divisão',
        isFavorite: false,
        logo:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/FC_Barcelona_logo.svg/1200px-FC_Barcelona_logo.svg.png',
        clubId: 'team_06',
        siglas: 'FPP',
      ),
      Team(
        id: 'team_07',
        name: 'SL Benfica',
        isSelected: false,
        federacion: 'FPP',
        liga: '1ª Divisão',
        isFavorite: false,
        logo:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/FC_Barcelona_logo.svg/1200px-FC_Barcelona_logo.svg.png',
        clubId: 'team_07',
        siglas: 'SLB',
      ),
      Team(
        id: 'team_08',
        name: 'Sporting CP',
        isSelected: false,
        federacion: 'FPP',
        liga: '1ª Divisão',
        isFavorite: false,
        logo:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/FC_Barcelona_logo.svg/1200px-FC_Barcelona_logo.svg.png',
        clubId: 'team_08',
        siglas: 'SCP',
      ),
      Team(
        id: 'team_09',
        name: 'UD Oliveirense',
        isSelected: false,
        federacion: 'FPP',
        liga: '1ª Divisão',
        isFavorite: false,
        logo:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/FC_Barcelona_logo.svg/1200px-FC_Barcelona_logo.svg.png',
        clubId: 'team_09',
        siglas: 'UDO',
      ),
      Team(
        id: 'team_10',
        name: 'OC Barcelos',
        isSelected: false,
        federacion: 'FPP',
        liga: '1ª Divisão',
        isFavorite: false,
        logo:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/FC_Barcelona_logo.svg/1200px-FC_Barcelona_logo.svg.png',
        clubId: 'team_10',
        siglas: 'OCB',
      ),
    ];

    db.addTeams(authService.currentUser!.uid, teams);
  }
}
