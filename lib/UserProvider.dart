import 'package:flutter/material.dart';
import 'package:test_app/Chat.dart';
import 'Usuario.dart';


class UserManager extends ChangeNotifier {
  List<Usuario> _usuarios = [];
  Usuario? _currentUser;
  Usuario? _chatUser;
  List<Mensaje>? _mensajes = [];





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




    _usuarios = [user1, user2, user3, user4];
    notifyListeners();

  }




  List<Usuario> get usuarios => _usuarios;
  Usuario? get currentUser => _currentUser;
  Usuario? get chatUser => _chatUser;
  List<Mensaje>? get mensajes => _mensajes;

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

  void setChatUser(Usuario user) {
    _chatUser = user;
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
    _currentUser = invitado;
    notifyListeners();
  }

  void enviarMensaje(Mensaje message) {
    Usuario currentUser = _currentUser!;
    Usuario chatUser = _chatUser!;

    // Busca el chat existente o crea uno nuevo si no existe
    Chat chat = currentUser.chats.firstWhere(
          (chat) => chat.usuarios!.contains(chatUser),
      orElse: () {
        Chat newChat = Chat(usuarios: [currentUser, chatUser], mensajes: []);
        currentUser.chats.add(newChat);
        chatUser.chats.add(newChat);
        return newChat;
      },
    );

    // Añade el mensaje al chat
    chat.mensajes?.add(message);
    notifyListeners();
  }

  List<Mensaje>? getMessages(Usuario? currentUser, Usuario? chatUser) {
    if (currentUser == null || chatUser == null) {
      return [];
    }
    Chat? chat = currentUser.chats.firstWhere(
          (chat) => chat.usuarios!.contains(chatUser),
      orElse: () => Chat(usuarios: [currentUser, chatUser], mensajes: []),
    );
    return chat.mensajes;
  }
}