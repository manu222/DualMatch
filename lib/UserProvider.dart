import 'package:flutter/material.dart';
import 'Matches.dart';
import 'Usuario.dart';


class UserManager extends ChangeNotifier {
  List<Usuario> _usuarios = [];
  Usuario? _currentUser;

  void initializeUsers(){
    Usuario user1 = Usuario(
      nombre: 'Sandra',
      contrasena: '1234',
      email: 'sandra@mail.com',
      bio: 'Hola, soy Sandra, me gusta el cine y la música',
      intereses: ['Cine', 'Música'],
      genero: 'Femenino',
      edadInicial: 18,
      edadFinal: 30,
      distanciaInicial: 0,
      distanciaFinal: 10,
      notificaciones: true,
      privacidad: 'Público',
      region: 'España',
      idioma: 'Español',
      imagenesInteligentes: true,
      telefono: 1234567890,
      amigo: null,
      likes: [],
      matches: [],
      chats: [],
    );
    Usuario user2 = Usuario(
      nombre: 'Maria',
      contrasena: '1234',
      email: 'maria@mail.com',
      bio: 'Hola, soy Maria, me gusta el deporte y la lectura',
      intereses: ['Deporte', 'Lectura'],
      genero: 'Femenino',
      edadInicial: 18,
      edadFinal: 30,
      distanciaInicial: 0,
      distanciaFinal: 10,
      notificaciones: true,
      privacidad: 'Público',
      region: 'España',
      idioma: 'Español',
      imagenesInteligentes: true,
      telefono: 1234567890,
      amigo: null,
      likes: [],
      matches: [],
      chats: [],
    );
    Usuario user3 = Usuario(
      nombre: 'Carlos',
      contrasena: '1234',
      email: 'carlos@mail.com',
      bio: 'Hola, soy Carlos, me gusta la música y el cine',
      intereses: ['Música', 'Cine'],
      genero: 'Masculino',
      edadInicial: 18,
      edadFinal: 30,
      distanciaInicial: 0,
      distanciaFinal: 10,
      notificaciones: true,
      privacidad: 'Público',
      region: 'España',
      idioma: 'Español',
      imagenesInteligentes: true,
      telefono: 1234567890,
      amigo: null,
      likes: [],
      matches: [],
      chats: [],
    );
    Usuario user4 = Usuario(
      nombre: 'Pedro',
      contrasena: '1234',
      email: 'pedro@mail.com',
      bio: 'Hola, soy Pedro, me gusta el deporte y las interfaces de usuario =) ',
      intereses: ['Deporte', 'Interfaces de usuario =)'],
      genero: 'Masculino',
      edadInicial: 18,
      edadFinal: 30,
      distanciaInicial: 0,
      distanciaFinal: 10,
      notificaciones: true,
      privacidad: 'Público',
      region: 'España',
      idioma: 'Español',
      imagenesInteligentes: true,
      telefono: 1234567890,
      amigo: null,
      likes: [],
      matches: [],
      chats: [],
    );

    user1.setAmigo(user2);
    user2.setAmigo(user1);
    user3.setAmigo(user4);
    user4.setAmigo(user3);

    user1.setLikes([user3]);
    user2.setLikes([user4]);
    user3.setLikes([user1]);
    user4.setLikes([user2]);

    List<Matches> matches1 = [Matches(usuarios: [user3, user4])];
    List<Matches> matches2 = [Matches(usuarios: [user1, user2])];

    user1.setMatches(matches1);
    user2.setMatches(matches1);
    user3.setMatches(matches2);
    user4.setMatches(matches2);

    user1.setChats([user2.nombre, user3.nombre, user4.nombre]);
    user2.setChats([user1.nombre, user3.nombre, user4.nombre]);
    user3.setChats([user1.nombre, user2.nombre, user4.nombre]);
    user4.setChats([user1.nombre, user2.nombre, user3.nombre]);

    _usuarios = [user1, user2, user3, user4];
    notifyListeners();

  }





  List<Usuario> get usuarios => _usuarios;
  Usuario? get currentUser => _currentUser;

  void addUsuario(Usuario usuario) {
    _usuarios.add(usuario);
    notifyListeners();
  }

  void removeUsuario(Usuario usuario) {
    _usuarios.remove(usuario);
    notifyListeners();
  }

  Usuario? getUsuarioByEmail(String email) {
    try {
      return _usuarios.firstWhere((user) => user.email == email);
    } catch (_) {
      return null;
    }
  }


  void setUsuarios(List<Usuario> usuarios) {
    _usuarios = usuarios;
    notifyListeners();
  }

  void addUser(Usuario newUser) {
    _usuarios.add(newUser);
    notifyListeners();
  }

  void setCurrentUser(Usuario user) {
    _currentUser = user;
    notifyListeners();
  }

  Usuario invitado = Usuario(
    nombre: 'Invitado',
    contrasena: '',
    email: '',
    bio: '',
    intereses: [],
    genero: '',
    edadInicial: 0,
    edadFinal: 0,
    distanciaInicial: 0,
    distanciaFinal: 0,
    notificaciones: false,
    privacidad: '',
    region: '',
    idioma: '',
    imagenesInteligentes: false,
    telefono: 0,
    amigo: null,
    likes: [],
    matches: [],
    chats: [],
  );

  void logout() {
    _currentUser =  invitado;
    notifyListeners();
  }
}
