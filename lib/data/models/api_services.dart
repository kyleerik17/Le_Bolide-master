class Piece {
  final int id;
  final String img;
  final String libelle;
  final String description;
  final String price;

  Piece({
    required this.id,
    required this.img,
    required this.libelle,
    required this.description,
    required this.price,
  });

  factory Piece.fromJson(Map<String, dynamic> json) {
    return Piece(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id'].toString()) ?? 0,
      img: json['img'] ?? '',
      libelle: json['libelle'] ?? '',
      description: json['description'] ?? '',
      price: json['price']?.toString() ?? '',
    );
  }
}

// const String baseUrl = 'https://bolide.armasoft.ci/bolide_services/index.php/';
const String baseUrl = 'http://192.168.1.4/rest-api/';
