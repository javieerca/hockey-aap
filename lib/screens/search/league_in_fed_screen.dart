import 'package:flutter/material.dart';

class LeagueInFedScreen extends StatefulWidget {
  final String federationId;
  const LeagueInFedScreen({super.key, required this.federationId});

  @override
  State<LeagueInFedScreen> createState() => _LeagueInFedScreenState();
}

class _LeagueInFedScreenState extends State<LeagueInFedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(145, 155, 160, 1),
      appBar: AppBar(
        title: Text(widget.federationId),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(145, 155, 160, 1),
      ),
      body: const Center(child: Text('LeagueInFedScreen')),
    );
  }
}
