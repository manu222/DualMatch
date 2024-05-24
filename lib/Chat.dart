import 'Usuario.dart';

class Mensaje {
  final Usuario usuario;
  final String texto;

  Mensaje({
    required this.usuario,
    required this.texto,
  });
}

class Chat {
  final List<Usuario> usuarios;
  final List<Mensaje> mensajes;

  Chat({
    required this.usuarios,
    required this.mensajes,
  });

  void enviarMensaje(Usuario usuario, String texto) {
    mensajes.add(Mensaje(usuario: usuario, texto: texto));
  }
}