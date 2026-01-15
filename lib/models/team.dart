class Team {
  final String id;
  final String name;
  final bool isSelected;
  final String federacion;
  final String liga;

  Team({
    required this.id,
    required this.name,
    this.isSelected = false,
    required this.federacion,
    required this.liga,
  });

  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
      id: map['teamId'] ?? '',
      name: map['teamName'] ?? '',
      isSelected: map['isSelected'] ?? false,
      federacion: map['federacion'] ?? '',
      liga: map['liga'] ?? '',
    );
  }
}
