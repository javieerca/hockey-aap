class Federation {
  final String id;
  final String name; // nombre
  final String acronym; // acronimo
  final String community; // comunidad
  final String website; // url
  final String? logoUrl; // logo (puede venir null o roto, mejor prevenir)
  final String? lineaUrl; // lineaurl
  final bool isActive; // estado ("1" -> true)

  Federation({
    required this.id,
    required this.name,
    required this.acronym,
    required this.community,
    required this.website,
    this.logoUrl,
    this.lineaUrl,
    required this.isActive,
  });

  factory Federation.fromJson(Map<String, dynamic> json) {
    return Federation(
      id: json['id'] ?? '0', // Protección contra nulos
      name: json['nombre'] ?? 'Sin nombre',
      acronym: json['acronimo'] ?? '',
      community: json['comunidad'] ?? '',
      website: json['url'] ?? '',

      // A veces las URLs vienen vacías "" en lugar de null,
      // aquí aseguramos que si no hay url útil, sea null.
      logoUrl: (json['logo'] != null && json['logo'].toString().isNotEmpty)
          ? json['logo']
          : null,

      lineaUrl:
          (json['lineaurl'] != null && json['lineaurl'].toString().isNotEmpty)
          ? json['lineaurl']
          : null,

      // Convertimos el "1" o "0" del string a un booleano real
      isActive: json['estado'] == "1",
    );
  }
}
