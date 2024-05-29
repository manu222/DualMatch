import 'Matches.dart';

class Usuario {
  String nombre;
  String contrasena;
  Usuario? amigo ;
  String email;
  int telefono;
  List<Usuario> likes;
  List<Matches> matches;
  List<String> chats;
  String? bio;
  String? intereses;
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

//haz getters y setters
  String getNombre() {
    return nombre;
  }

  void setMail(String email) {
    this.email = email;
  }

  String getMail() {
    return email;
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

  void setTelefono(int telefono) {
    this.telefono = telefono;
  }

  int getTelefono() {
    return telefono;
  }

  void setEmail(String email) {
    this.email = email;
  }

  String getEmail() {
    return email;
  }

  void setBio(String bio) {
    this.bio = bio;
  }

  String? getBio() {
    return bio;
  }

  void setIntereses(String intereses) {
    this.intereses = intereses;
  }

  String? getIntereses() {
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
      matches: (json['matches'] as List).map((matchJson) => Matches.fromJson(matchJson)).toList(),
      chats: List<String>.from(json['chats']),
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




}