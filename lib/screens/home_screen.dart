import 'package:flutter/material.dart';
import 'package:hockey_app/screens/favourites_screen.dart';
import 'package:hockey_app/screens/profile_screen.dart';
import 'package:hockey_app/services/auth_service.dart';
import 'package:hockey_app/services/firestore_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> _teams = [];
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

  int _selectedIndex = 2;

  List<Widget> get _pantallas => <Widget>[
    const Center(
      child: Text(
        'Pantalla 1: Resultados y Partidos',
        style: TextStyle(fontSize: 20),
      ),
    ),
    const Center(
      child: Text('Pantalla 2: Clasificación', style: TextStyle(fontSize: 20)),
    ),
    Center(child: FavouritesScreen(teams: _teams)),
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Estamos buscando tus equipos..."),
              SizedBox(height: 16),
              CircularProgressIndicator(),
            ],
          ),
        ),
      );
    }

    if (_teams.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Center(child: Text('Bienvenido'))),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('No tienes equipos asignados.'),
              const SizedBox(height: 20),
              ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    leading: const Icon(Icons.shield),
                    title: const Text('FC Barcelona'),
                    trailing: const Icon(Icons.add),
                    onTap: () {
                      firestoreService.addTeam(
                        authService.currentUser!.uid,
                        'FC Barcelona',
                      );
                      _loadUser();
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.shield),
                    title: const Text('Real Madrid FC'),
                    trailing: const Icon(Icons.add),
                    onTap: () {
                      firestoreService.addTeam(
                        authService.currentUser!.uid,
                        'Real Madrid FC',
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Equipo agregado correctamente'),
                        ),
                      );
                      _loadUser();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      //body cambia segun el indice
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
            icon: Icon(Icons.sports_hockey),
            label: 'Partidos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_numbered),
            label: 'Clasificación',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border),
            activeIcon: Icon(Icons.star), // Icono relleno cuando está activo
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Perfil',
          ),
        ],
      ),
    );

    // return Scaffold(
    //   backgroundColor: const Color.fromARGB(172, 245, 245, 245),
    //   appBar: AppBar(
    //     title: const Text('Dashboard'),
    //     actions: [
    //       IconButton(
    //         icon: const Icon(Icons.logout),
    //         onPressed: () async {
    //           await authService.signOut();
    //           // Navigation handled by StreamBuilder in main.dart
    //         },
    //       ),
    //     ],
    //   ),
    //   body: Padding(
    //     padding: const EdgeInsets.all(16),
    //     child: Center(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           const Icon(
    //             Icons.check_circle_outline,
    //             size: 100,
    //             color: Colors.green,
    //           ),
    //           const SizedBox(height: 20),
    //           const Text(
    //             '¡Bienvenido!',
    //             style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    //           ),
    //           const SizedBox(height: 10),
    //           Text(
    //             'Sesión iniciada como:',
    //             style: TextStyle(fontSize: 16, color: Colors.grey[600]),
    //           ),
    //           Text(
    //             authService.currentUser?.email ?? 'Usuario desconocido',
    //             style: const TextStyle(
    //               fontSize: 20,
    //               fontWeight: FontWeight.w500,
    //             ),
    //           ),
    //           const SizedBox(height: 40),
    //           Card(
    //             elevation: 4,
    //             child: Padding(
    //               padding: const EdgeInsets.all(16.0),
    //               child: Column(
    //                 children: [
    //                   const ListTile(
    //                     leading: Icon(Icons.info),
    //                     title: Text('Firebase Auth Boilerplate'),
    //                     subtitle: Text(
    //                       'Este es un proyecto base listo para usar.',
    //                     ),
    //                   ),
    //                   const Divider(),
    //                   const Text(
    //                     'Aquí puedes comenzar a construir tu aplicación.',
    //                   ),
    //                   const SizedBox(height: 10),
    //                   Text('Equipos: ${_teams.length}'),
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
