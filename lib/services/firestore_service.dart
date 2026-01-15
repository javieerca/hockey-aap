import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hockey_app/models/team.dart';

class FirestoreService {
  //obtener la instancia de la base de datos
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //agregar un documento a la coleccion
  Future<void> saveUser(String uid, String email) async {
    await _db.collection('users').doc(uid).set({
      'email': email,
      'registrationDate': DateTime.now(),
    });
  }

  Future<List<Team>> getTeams(String uid) async {
    final response = await _db
        .collection('users')
        .doc(uid)
        .collection('favteams')
        .get();
    if (response.docs.isNotEmpty) {
      return response.docs.map((doc) => Team.fromMap(doc.data())).toList();
    }
    return [];
  }

  Stream<List<Team>> getTeamsStream(String uid) {
    return _db
        .collection('users')
        .doc(uid)
        .collection('favteams')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) => Team.fromMap(doc.data())).toList();
        });
  }

  Future<void> addTeams(String uid, List<Team> teams) async {
    for (var team in teams) {
      // Referencia al documento: colección 'teams', documento con el ID del equipo
      _db.collection('users').doc(uid).collection('favteams').doc(team.id).set({
        'teamId': team.id,
        'teamName': team.name,
        'federacion': team.federacion,
        'liga': team.liga,
      });
    }
  }

  Future<void> removeTeam(String uid, String teamId) async {
    await _db
        .collection('users')
        .doc(uid)
        .collection('favteams')
        .doc(teamId)
        .delete();
  }
}
