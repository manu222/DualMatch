import 'Matches.dart';

class Usuario {
  String nombre;
  String contrasena;
  Usuario amigo;
  List<String> likes;
  List<Matches> matches;
  List<String> chats;

  Usuario({
    required this.nombre,
    required this.contrasena,
    required this.amigo,
    required this.likes,
    required this.matches,
    required this.chats,
  });

  Map<String, dynamic> toJson() => {
    'nombre': nombre,
    'contrasena': contrasena,
    'amigo': amigo.nombre,
    'likes': likes,
    'matches': matches,
    'chats': chats,
  };


  }


