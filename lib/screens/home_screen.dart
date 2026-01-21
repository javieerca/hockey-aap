import 'package:flutter/material.dart';
import 'package:hockey_app/models/team.dart';
import 'package:hockey_app/screens/favourites_screen.dart';
import 'package:hockey_app/screens/match_screen.dart';
import 'package:hockey_app/screens/profile_screen.dart';
import 'package:hockey_app/screens/search/search_tab_navigator.dart';
import 'package:hockey_app/services/auth_service.dart';
import 'package:hockey_app/services/firestore_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Team> _teams = [];
  bool _isLoading = true;
  final firestoreService = FirestoreService();
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() async {
    final user = authService.currentUser;
    if (user != null) {
      final favTeams = await firestoreService.getTeams(user.uid);
      if (mounted) {
        setState(() {
          _teams = favTeams;
          _isLoading = false;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  int _selectedIndex = 3;

  List<Widget> get _pantallas => <Widget>[
    const Center(child: FavouritesScreen()),
    const Center(
      child: Text('Pantalla 2: Clasificación', style: TextStyle(fontSize: 20)),
    ),
    const Center(child: MatchScreen()),
    const SearchTabNavigator(),
    const Center(child: ProfileScreen()),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Color.fromRGBO(145, 155, 160, 1),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Estamos buscando tus equipos...",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 16),
              CircularProgressIndicator(),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      //body cambia segun el  indice
      body: _pantallas[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        // Propiedades Estéticas
        type: BottomNavigationBarType
            .fixed, // <--- IMPORTANTE: Si tienes +3 botones, pon esto o se volverá blanco
        backgroundColor: Colors.white,

        selectedItemColor: const Color.fromARGB(
          255,
          0,
          105,
          180,
        ), // Tu azul Hockey
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true, // Mostrar texto aunque no esté activo
        elevation: 10, // Sombrita arriba del menú
        // Propiedades Lógicas
        currentIndex: _selectedIndex, // Le dice al menú cuál pintar de azul
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border),
            activeIcon: Icon(Icons.star), // Icono relleno cuando está activo
            label: 'Mis equipos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_numbered),
            label: 'Clasificación',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_hockey),
            label: 'Partidos',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
