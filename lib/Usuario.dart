class Usuario {
  String nombre;
  String contrasena;
  List<String> likes;
  List<String> matches;
  List<String> chats;

  Usuario({
    required this.nombre,
    required this.contrasena,
    required this.likes,
    required this.matches,
    required this.chats,
  });

  Map<String, dynamic> toJson() => {
    'nombre': nombre,
    'contrasena': contrasena,
    'likes': likes,
    'matches': matches,
    'chats': chats,
  };

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      nombre: json['nombre'],
      contrasena: json['contrasena'],
      likes: List<String>.from(json['likes']),
      matches: List<String>.from(json['matches']),
      chats: List<String>.from(json['chats']),
    );
  }
}