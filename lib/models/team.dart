class Team {
  final String id;
  final String name;
  final bool isSelected;
  final String federacion;
  final String liga;
  final bool isFavorite;
  final String logo;
  final String clubId;
  final String siglas;

  Team({
    required this.id,
    required this.name,
    this.isSelected = false,
    required this.federacion,
    required this.liga,
    required this.isFavorite,
    required this.logo,
    required this.clubId,
    required this.siglas,
  });

  factory Team.fromJson(Map<String, dynamic> map) {
    return Team(
      id: map['idEquipo'] ?? '',
      name: map['nombre'] ?? '',
      isSelected: map['isSelected'] ?? false,
      federacion: map['fed'] ?? '',
      liga: map['liga'] ?? '',
      isFavorite: map['isFavorite'] ?? false,
      logo: map['logo'] ?? '',
      clubId: map['clubId'] ?? '',
      siglas: map['siglas'] ?? '',
    );
  }
}
