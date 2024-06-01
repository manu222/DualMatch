import 'Usuario.dart';

class Mensaje {
   Usuario? emisor;
   Usuario? receptor;
   String? texto;

  Mensaje(this.emisor, this.receptor, this.texto);

}

class Chat {
   List<Usuario>? usuarios;
   List<Mensaje>? mensajes;

  Chat({
    required this.usuarios,
    required this.mensajes,
  });

  void enviarMensaje(Mensaje mensaje) {
    mensajes?.add(mensaje);
  }
  //cargar mensajes
  void cargarMensajes(List<Mensaje> mensajes) {
    this.mensajes?.addAll(mensajes);
  }

  //obtener mensajes
  List<Mensaje>? getMensajes() {
    return mensajes;
  }

  //obtener usuarios
  List<Usuario>? getUsuarios() {
    return usuarios;
  }

  void addMensaje(Mensaje mensaje) {
    mensajes?.add(mensaje);
  }

}