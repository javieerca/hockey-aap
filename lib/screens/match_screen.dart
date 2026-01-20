import 'package:flutter/material.dart';
import 'package:hockey_app/services/auth_service.dart';
import 'package:hockey_app/services/firestore_service.dart';
import 'package:hockey_app/widgets/appbar/appbar_items.dart';

class MatchScreen extends StatefulWidget {
  const MatchScreen({super.key});

  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  String favTeamName = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getFavTeamName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(145, 155, 160, 1),
      appBar: AppBar(
        title: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : AppbarText(text: favTeamName),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(145, 155, 160, 1),
      ),
      body: const Center(
        child: Text('Partidos', style: TextStyle(fontSize: 20)),
      ),
    );
  }

  // TODO: Obtener el equipo favorito del usuario
  Future<String> getFavTeamName() async {
    final FirestoreService db = FirestoreService();
    final AuthService authService = AuthService();
    final user = authService.currentUser;
    if (user != null) {
      final name = await db.getFavTeamName(user.uid);
      setState(() {
        favTeamName = name;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
    return favTeamName;
  }
}
