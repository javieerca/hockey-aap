import 'package:flutter/material.dart';
import 'package:hockey_app/models/league.dart';
import 'package:hockey_app/services/api_service.dart';
import 'package:hockey_app/widgets/appbar/appbar_items.dart';
import 'package:hockey_app/widgets/modality_in_fed.dart';

class LeagueInFedScreen extends StatefulWidget {
  final String acronimoFed;
  const LeagueInFedScreen({super.key, required this.acronimoFed});

  @override
  State<LeagueInFedScreen> createState() => _LeagueInFedScreenState();
}

class _LeagueInFedScreenState extends State<LeagueInFedScreen> {
  List<League> ligasPatines = [];
  List<League> ligasLinea = [];
  List<League> ligasHielo = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLeagues();
  }

  Future<void> _loadLeagues() async {
    ApiService apiService = ApiService();
    apiService.getLeaguesfromFed(widget.acronimoFed).then((leagues) {
      setState(() {
        ligasPatines = leagues.where((league) => league.modality == 1).toList();
        ligasLinea = leagues.where((league) => league.modality == 2).toList();
        ligasHielo = leagues.where((league) => league.modality == 3).toList();
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(145, 155, 160, 1),
      appBar: AppBar(
        title: AppbarText(text: widget.acronimoFed),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(145, 155, 160, 1),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              if (_isLoading)
                const CircularProgressIndicator(color: Colors.white),
              if (ligasPatines.isNotEmpty) ModalityInFed(ligas: ligasPatines),
              Divider(),

              if (ligasLinea.isNotEmpty) ModalityInFed(ligas: ligasLinea),

              if (ligasHielo.isNotEmpty) ModalityInFed(ligas: ligasHielo),
            ],
          ),
        ),
      ),
    );
  }
}
