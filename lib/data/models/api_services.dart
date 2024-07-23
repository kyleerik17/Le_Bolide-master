class Piece {
  final int id;
  final String img;
  final String libelle;
  final String description;
  final String price;
  final int categoryId;
  final int vehicleId;
  final String createdAt;
  final String? updatedAt;

  Piece({
    required this.id,
    required this.img,
    required this.libelle,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.vehicleId,
    required this.createdAt,
    this.updatedAt,
  });

  factory Piece.fromJson(Map<String, dynamic> json) {
    return Piece(
      id: int.parse(json['id']),
      img: json['img'],
      libelle: json['libelle'],
      description: json['description'],
      price: json['price'],
      categoryId: int.parse(json['category_id']),
      vehicleId: int.parse(json['vehicle_id']),
      createdAt: json['created_at'],
      updatedAt: json['update_at'],
    );
  }
}


