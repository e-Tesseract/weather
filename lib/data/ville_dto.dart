class VilleDTO {
  final int? id;
  final String name;

  VilleDTO({this.id, required this.name});

  // Convertir un Map en VilleDTO
  factory VilleDTO.fromMap(Map<String, dynamic> json) => new VilleDTO(
    id: json["id"],
    name: json["name"],
  );

  // Convertir un VilleDTO en Map
  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
  };
}