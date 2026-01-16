import 'package:flutter/material.dart';

class MyNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MyNavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // Propiedades Estéticas
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color.fromRGBO(145, 155, 160, 1),

      selectedItemColor: const Color.fromARGB(
        255,
        0,
        105,
        180,
      ), // Tu azul Hockey
      unselectedItemColor: Colors.black54,
      showUnselectedLabels: true, // Mostrar texto aunque no esté activo
      elevation: 10, // Sombrita arriba del menú
      // Propiedades Lógicas
      currentIndex: currentIndex,
      onTap: onTap,
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
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Perfil',
        ),
      ],
    );
  }
}
