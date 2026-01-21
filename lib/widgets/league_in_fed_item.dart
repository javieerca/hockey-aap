import 'package:flutter/material.dart';
import 'package:hockey_app/models/league.dart';
import 'package:hockey_app/models/team.dart';
import 'package:hockey_app/services/api_service.dart';
import 'package:hockey_app/widgets/team_item.dart';

class LeagueInFedItem extends StatefulWidget {
  const LeagueInFedItem({super.key, required this.league});

  final League league;

  @override
  State<LeagueInFedItem> createState() => _LeagueInFedItemState();
}

class _LeagueInFedItemState extends State<LeagueInFedItem> {
  List<Team> teams = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTeams();
  }

  Future<void> _loadTeams() async {
    ApiService apiService = ApiService();
    apiService.getTeamsfromLeague(widget.league.id.toString()).then((teams) {
      setState(() {
        this.teams = teams;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(widget.league.name),
      children: [
        if (_isLoading) const CircularProgressIndicator(color: Colors.white),
        for (var team in teams) TeamItem(team: team),
      ],
    );
  }
}
