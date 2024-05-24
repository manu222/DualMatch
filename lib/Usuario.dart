import 'Matches.dart';

class Usuario {
  String nombre;
  String contrasena;
  Usuario? amigo ;
  List<Usuario> likes;
  List<Matches> matches;
  List<String> chats;

  Usuario({
    required this.nombre,
    required this.contrasena,
    this.amigo,
    required this.likes,
    required this.matches,
    required this.chats,
  });

//haz getters y setters
  String getNombre() {
    return nombre;
  }

  void setNombre(String nombre) {
    this.nombre = nombre;
  }

  String getContrasena() {
    return contrasena;
  }

  void setContrasena(String contrasena) {
    this.contrasena = contrasena;
  }

  Usuario? getAmigo() {
    return amigo;
  }

  void setAmigo(Usuario amigo) {
    this.amigo = amigo;
  }

  List<Usuario> getLikes() {
    return likes;
  }

  void setLikes(List<Usuario> likes) {
    this.likes = likes;
  }

  List<Matches> getMatches() {
    return matches;
  }

  void setMatches(List<Matches> matches) {
    this.matches = matches;
  }

  List<String> getChats() {
    return chats;
  }

  void setChats(List<String> chats) {
    this.chats = chats;
  }

  void addLike(Usuario like) {
    likes.add(like);
  }

  void addMatch(Matches match) {
    matches.add(match);
  }

  void addChat(String chat) {
    chats.add(chat);
  }

  void removeLike(String like) {
    likes.remove(like);
  }

  void removeMatch(Matches match) {
    matches.remove(match);
  }

  void removeChat(String chat) {
    chats.remove(chat);
  }



}