import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<List<String>> getTeams(String uid) async {
    final teams = await _db
        .collection('users')
        .doc(uid)
        .collection('favteams')
        .get();
    if (teams.docs.isNotEmpty) {
      return teams.docs.map((doc) => doc.id).toList();
    }
    return [];
  }

  Future<void> addTeam(String uid, String teamId) async {
    await _db
        .collection('users')
        .doc(uid)
        .collection('favteams')
        .doc(teamId)
        .set({'teamId': teamId});
  }
}
