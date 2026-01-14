import 'package:flutter/material.dart';

class AddFavScreen extends StatefulWidget {
  const AddFavScreen({super.key});

  @override
  State<AddFavScreen> createState() => _AddFavScreenState();
}

class _AddFavScreenState extends State<AddFavScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Agregar equipo favorito'),
            ElevatedButton(onPressed: () {}, child: Text('Agregar')),
          ],
        ),
      ),
    );
  }
}
