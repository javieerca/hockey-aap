class League {
  final int id;
  final String name;
  final String acronimoFed;
  final int modality;
  // 1: Hockey Patines, 2: Hockey Linea 3:Hockey Hielo

  League({
    required this.id,
    required this.name,
    required this.acronimoFed,
    required this.modality,
  });

  factory League.fromJson(Map<String, dynamic> json) {
    return League(
      id: json['idc'],
      name: json['nombre'],
      acronimoFed: json['fed'],
      modality: json['idm'],
    );
  }
}
