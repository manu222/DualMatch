import 'Usuario.dart';

class Matches {
  final List<Usuario> usuarios;

  Matches({
    required this.usuarios,
  });

  bool isMatch() {
    for (var i = 0; i < usuarios.length; i++) {
      for (var j = i + 1; j < usuarios.length; j++) {
        if (usuarios[i].likes.contains(usuarios[j].nombre) && usuarios[j].likes.contains(usuarios[i].nombre)) {
          return true;
        }
      }
    }
    return false;
  }
}