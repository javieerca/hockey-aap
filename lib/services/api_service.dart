import 'dart:convert';

import 'package:hockey_app/models/federation.dart';
import 'package:hockey_app/models/league.dart';
import 'package:hockey_app/models/team.dart';
import 'package:hockey_app/services/auth_service.dart';
import 'package:hockey_app/services/firestore_service.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://41430439.servicio-online.net/api/v1/';
  final db = FirestoreService();
  final authService = AuthService();

  Future<List<Federation>> getFederations() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/federaciones.php'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> data = responseData['data'];
        final List<Federation> federations = data
            .map((json) => Federation.fromJson(json))
            .toList();
        return federations;
      } else {
        throw Exception('Failed to load federations');
      }
    } catch (e) {
      throw Exception('Failed to load federations');
    }
  }

  Future<Team> getTeamById(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/equipos.php?id=$id'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final Team team = Team.fromJson(responseData['data']);
        return team;
      } else {
        throw Exception('Failed to load team');
      }
    } catch (e) {
      throw Exception('Failed to load team');
    }
  }

  Future addFollowingTeam(Team team) async {
    await db.addTeam(team);
  }

  Future<List<League>> getLeaguesfromFed(String acronimoFed) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/ligas.php?fed=$acronimoFed'),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> leaguesResponse = responseData['ligas'];
        final List<League> leagues = leaguesResponse
            .map((json) => League.fromJson(json))
            .toList();
        return leagues;
      } else {
        throw Exception('Failed to load leagues');
      }
    } catch (e) {
      throw Exception('Failed to load leagues');
    }
  }

  Future<List<Team>> getTeamsfromLeague(String idcLeague) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/equipos.php?idc=$idcLeague'),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> teamsResponse = responseData['equipos'];
        final List<Team> teams = teamsResponse
            .map((json) => Team.fromJson(json))
            .toList();
        return teams;
      } else {
        throw Exception('Failed to load leagues');
      }
    } catch (e) {
      throw Exception('Failed to load leagues');
    }
  }
}
