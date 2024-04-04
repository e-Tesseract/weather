class VilleDTO {
  final int id;
  final String name;
  final int? population;

  VilleDTO({required this.id, required this.name, this.population});

  // Convertir un Map en VilleDTO
  factory VilleDTO.fromMap(Map<String, dynamic> json) => new VilleDTO(
    id: json["id"],
    name: json["name"],
    population: json["population"],
  );

  // Convertir un VilleDTO en Map
  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "population": population,
  };
}