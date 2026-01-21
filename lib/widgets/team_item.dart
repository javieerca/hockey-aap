import 'package:flutter/material.dart';
import 'package:hockey_app/models/team.dart';

class TeamItem extends StatelessWidget {
  const TeamItem({super.key, required this.team});

  final Team team;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Row(
            children: [
              //Image(image: NetworkImage(team.logo)),
              SizedBox(width: 64, child: Text(team.siglas)),
            ],
          ),
          SizedBox(width: 16),
          Text(team.name),
        ],
      ),
    );
  }
}
