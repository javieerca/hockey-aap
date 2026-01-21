import 'package:flutter/material.dart';
import 'package:hockey_app/models/federation.dart';
import 'package:hockey_app/screens/search/leagues_in_fed_screen.dart';
import 'package:hockey_app/services/api_service.dart';
import 'package:hockey_app/widgets/appbar/appbar_items.dart';

class SearchTeamScreen extends StatefulWidget {
  const SearchTeamScreen({super.key});

  @override
  State<SearchTeamScreen> createState() => _SearchTeamScreenState();
}

class _SearchTeamScreenState extends State<SearchTeamScreen> {
  final ApiService _apiService = ApiService();
  late Future<List<Federation>> _federationsFuture;

  @override
  void initState() {
    super.initState();
    _federationsFuture = _apiService.getFederations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(145, 155, 160, 1),
      appBar: AppBar(
        title: const AppbarText(text: 'Federaciones'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(145, 155, 160, 1),
      ),
      body: FutureBuilder<List<Federation>>(
        future: _federationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay federaciones disponibles'));
          }

          final federations = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.85,
            ),
            itemCount: federations.length,
            itemBuilder: (context, index) {
              final federation = federations[index];
              return Card(
                elevation: 2,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    // Navigate to LeagueInFedScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LeagueInFedScreen(
                          acronimoFed: federation.acronym.toUpperCase(),
                        ),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: federation.logoUrl != null
                              ? Image.network(
                                  federation.logoUrl!,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                        Icons.image_not_supported,
                                        size: 50,
                                        color: Colors.grey,
                                      ),
                                )
                              : const Icon(
                                  Icons.sports_hockey,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
                        child: Text(
                          federation.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.black87,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
