import 'Usuario.dart';

class Matches {

  List<Usuario> usuarios;

  Matches({required this.usuarios});

  Map<String, dynamic> toJson() {
    return {
      'usuarios': usuarios.map((usuario) => usuario.toJson()).toList(),
    };
  }

  factory Matches.fromJson(Map<String, dynamic> json) {
    return Matches(
      usuarios: (json['usuarios'] as List).map((usuarioJson) => Usuario.fromJson(usuarioJson)).toList(),
    );
  }

  bool isMatch(Usuario user1, Usuario user2) {
    return user1.likes.contains(user2) && user2.likes.contains(user1);
  }

}