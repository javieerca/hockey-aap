import 'package:flutter/material.dart';
import 'package:hockey_app/screens/search/search_team_screen.dart';

class SearchTabNavigator extends StatefulWidget {
  const SearchTabNavigator({super.key});

  @override
  State<SearchTabNavigator> createState() => _SearchTabNavigatorState();
}

class _SearchTabNavigatorState extends State<SearchTabNavigator> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        final isFirstRouteInCurrentTab = !await navigatorKey.currentState!
            .maybePop();

        // Si no se puede hacer pop en el navegador anidado, dejamos que el sistema
        // maneje el pop (por ejemplo, saliendo de la app o volviendo atrás en el navegador principal si hubiera)
        // Pero en una estructura de Tabs, generalmente queremos que si es la primera ruta, no haga nada o salga.
        // Aquí, simplemente si no puede hacer pop, no hacemos nada explícito,
        // pero podríamos permitir salir de la app si fuera necesario.
        // Para permitir el comportamiento por defecto si estamos en la raíz:
        if (isFirstRouteInCurrentTab) {
          // Si estamos en la raíz del navegador anidado, podríamos querer salir de la app
          // o simplemente no hacer nada. Si devolvemos false a canPop (arriba), el sistema no hace pop.
          // Si queremos permitir que salga de la app, tendríamos que gestionar eso con el Navigator principal.
          // Por ahora, para simular el comportamiento estándar de tabs:
          // Si estamos en la raíz, no hacemos pop del tab, el usuario debe cambiar de tab manualmente.
        }
      },
      child: Navigator(
        key: navigatorKey,
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (BuildContext context) => const SearchTeamScreen(),
          );
        },
      ),
    );
  }
}
