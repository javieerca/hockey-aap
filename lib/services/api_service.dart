import 'dart:convert';

import 'package:hockey_app/models/federation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://41430439.servicio-online.net/api/v1/';
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
}
