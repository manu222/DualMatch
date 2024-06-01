import 'package:test_app/Chat.dart';


class Usuario {
  String nombre;
  String contrasena;
  Usuario? amigo;
  String email;
  int telefono;
  List<Usuario> likes;
  List<Usuario> matches;
  List<Chat> chats;
  String? bio;
  List<String>? intereses;
  String? genero;
  int? edadInicial;
  int? edadFinal;
  int? distanciaInicial;
  int? distanciaFinal;
  bool? notificaciones;
  String? privacidad;
  String? region;
  String? idioma;
  bool? imagenesInteligentes;

  Usuario({
    required this.nombre,
    required this.contrasena,
    this.amigo,
    required this.telefono,
    required this.email,
    required this.likes,
    required this.matches,
    required this.chats,
    this.bio,
    this.intereses,
    this.genero,
    this.edadInicial,
    this.edadFinal,
    this.distanciaInicial,
    this.distanciaFinal,
    this.notificaciones,
    this.privacidad,
    this.region,
    this.idioma,
    this.imagenesInteligentes,
  });

  // Getters y setters
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

  String getEmail() {
    return email;
  }

  void setEmail(String email) {
    this.email = email;
  }

  int getTelefono() {
    return telefono;
  }

  void setTelefono(int telefono) {
    this.telefono = telefono;
  }

  List<Usuario> getLikes() {
    return likes;
  }

  void setLikes(List<Usuario> likes) {
    this.likes = likes;
  }

  List<Usuario> getMatches() {
    return matches;
  }

  void setMatches(List<Usuario> matches) {
    this.matches = matches;
  }

  List<Chat> getChats() {
    return chats;
  }

  void setChats(List<Chat> chats) {
    this.chats = chats;
  }

  void addLike(Usuario like) {
    likes.add(like);
  }

  void addMatch(Usuario match) {
    matches.add(match);
  }

  void addChat(Chat chat) {
    chats.add(chat);
  }

  void removeLike(Usuario like) {
    likes.remove(like);
  }

  void removeMatch(Usuario match) {
    matches.remove(match);
  }

  void removeChat(String chat) {
    chats.remove(chat);
  }

  void setBio(String bio) {
    this.bio = bio;
  }

  String? getBio() {
    return bio;
  }

  void setIntereses(List<String> intereses) {
    this.intereses = intereses;
  }

  List<String>? getIntereses() {
    return intereses;
  }

  void setGenero(String genero) {
    this.genero = genero;
  }

  String? getGenero() {
    return genero;
  }

  void setEdadInicial(int edadInicial) {
    this.edadInicial = edadInicial;
  }

  int? getEdadInicial() {
    return edadInicial;
  }

  void setEdadFinal(int edadFinal) {
    this.edadFinal = edadFinal;
  }

  int? getEdadFinal() {
    return edadFinal;
  }

  void setDistanciaInicial(int distanciaInicial) {
    this.distanciaInicial = distanciaInicial;
  }

  int? getDistanciaInicial() {
    return distanciaInicial;
  }

  void setDistanciaFinal(int distanciaFinal) {
    this.distanciaFinal = distanciaFinal;
  }

  int? getDistanciaFinal() {
    return distanciaFinal;
  }

  void setNotificaciones(bool notificaciones) {
    this.notificaciones = notificaciones;
  }

  bool? getNotificaciones() {
    return notificaciones;
  }

  void setPrivacidad(String privacidad) {
    this.privacidad = privacidad;
  }

  String? getPrivacidad() {
    return privacidad;
  }

  void setRegion(String region) {
    this.region = region;
  }

  String? getRegion() {
    return region;
  }

  void setIdioma(String idioma) {
    this.idioma = idioma;
  }

  String? getIdioma() {
    return idioma;
  }

  void setImagenesInteligentes(bool imagenesInteligentes) {
    this.imagenesInteligentes = imagenesInteligentes;
  }

  bool? getImagenesInteligentes() {
    return imagenesInteligentes;
  }

  String getPassword() {
    return contrasena;
  }

  // Métodos para convertir a JSON y desde JSON
  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'contrasena': contrasena,
      'amigo': amigo?.toJson(),
      'telefono': telefono,
      'email': email,
      'likes': likes.map((like) => like.toJson()).toList(),
      'matches': matches.map((match) => match.toJson()).toList(),
      'chats': chats,
      'bio': bio,
      'intereses': intereses,
      'genero': genero,
      'edadInicial': edadInicial,
      'edadFinal': edadFinal,
      'distanciaInicial': distanciaInicial,
      'distanciaFinal': distanciaFinal,
      'notificaciones': notificaciones,
      'privacidad': privacidad,
      'region': region,
      'idioma': idioma,
      'imagenesInteligentes': imagenesInteligentes,
    };
  }

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      nombre: json['nombre'],
      contrasena: json['contrasena'],
      telefono: json['telefono'],
      email: json['email'],
      amigo: json['amigo'] != null ? Usuario.fromJson(json['amigo']) : null,
      likes: (json['likes'] as List).map((likeJson) => Usuario.fromJson(likeJson)).toList(),
      matches: (json['matches'] as List).map((matchJson) => Usuario.fromJson(matchJson)).toList(),
      chats: List<Chat>.from(json['chats']),
      bio: json['bio'],
      intereses: json['intereses'],
      genero: json['genero'],
      edadInicial: json['edadInicial'],
      edadFinal: json['edadFinal'],
      distanciaInicial: json['distanciaInicial'],
      distanciaFinal: json['distanciaFinal'],
      notificaciones: json['notificaciones'],
      privacidad: json['privacidad'],
      region: json['region'],
      idioma: json['idioma'],
      imagenesInteligentes: json['imagenesInteligentes'],
    );
  }

  String? getAmigoNombre() {
    return amigo?.nombre ?? "No tiene amigo";
  }

  @override
  String toString() {
    return "Nombre: $nombre, Email: $email, Telefono: $telefono\n"
        "bio: $bio intereses: $intereses genero: $genero edadInicial: $edadInicial\n"
        "edadFinal: $edadFinal distanciaInicial: $distanciaInicial distanciaFinal: $distanciaFinal notificaciones: $notificaciones\n"
        "privacidad: $privacidad region: $region idioma: $idioma imagenesInteligentes: $imagenesInteligentes Amigo: ${getAmigoNombre()}";
  }
}
