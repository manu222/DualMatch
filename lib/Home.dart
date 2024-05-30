import 'package:flutter/material.dart';
import 'package:test_app/Usuario.dart';
import 'package:test_app/perfil.dart';
import 'Matches.dart';

class PantallaPrincipal extends StatefulWidget {
  final Usuario? currentUser;
  List<Usuario>? usuarios;
  PantallaPrincipal({
    super.key,
    required this.currentUser,
    this.usuarios,
  });

  @override
  _PantallaPrincipalState createState() => _PantallaPrincipalState();
}

void mostrarIconoFlotante(BuildContext context, IconData icono, String mensaje) {
  OverlayState overlayState = Overlay.of(context);
  OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icono,
            color: Colors.red,
            size: 100.0,
          ),
          const SizedBox(height: 10),
          Text(
            mensaje,
            style: TextStyle(color: Colors.red, fontSize: 24),
          ),
        ],
      ),
    ),
  );
  overlayState.insert(overlayEntry);
  Future.delayed(const Duration(milliseconds: 500), () {
    overlayEntry.remove();
  });
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  int indiceActual = 0;

  late Usuario user1;
  late Usuario user2;
  late Usuario user3;
  late Usuario user4;

  @override
  void initState() {
    super.initState();
    user1 = Usuario(
      nombre: 'Sandra',
      contrasena: '1234',
      email: '',
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
    user2 = Usuario(
      nombre: 'Maria',
      contrasena: '1234',
      email: '',
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
    user3 = Usuario(
      nombre: 'Carlos',
      contrasena: '1234',
      email: '',
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
    user4 = Usuario(
      nombre: 'Pedro',
      contrasena: '1234',
      email: 'pedro@mail.com',
      bio: 'Hola, soy Pedro, me gusta el deporte y la lectura',
      intereses: ['Deporte', 'Lectura'],
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

    widget.currentUser!.setMatches(matches2);
    widget.currentUser!.setChats([user1.nombre, user2.nombre, user3.nombre, user4.nombre]);
    widget.currentUser!.setAmigo(user3);
  }

  final List<String> images = [
    'assets/U1.jpg',
    'assets/U2.jpg',
    'assets/U3.jpg',
    'assets/U4.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> pantallas = [
      images.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.pink.shade900),
                  ),
                ),
                SizedBox(
                  width: 110,
                  height: 110,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.pink.shade800),
                  ),
                ),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.pink.shade700),
                  ),
                ),
                SizedBox(
                  width: 90,
                  height: 90,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.pink.shade500),
                  ),
                ),
                SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.pink.shade200),
                  ),
                ),
                Image.asset(
                  'assets/icon.png',
                  width: 70,
                  height: 70,
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Buscando más perfiles en tu zona'),
          ],
        ),
      )
          : Stack(
        children: images.map((image) {
          int index = images.indexOf(image);
          String userName;
          switch (index) {
            case 0:
              userName = user1.nombre;
              break;
            case 1:
              userName = user2.nombre;
              break;
            case 2:
              userName = user3.nombre;
              break;
            case 3:
              userName = user4.nombre;
              break;
            default:
              userName = 'Usuario desconocido';
          }

          return Positioned.fill(
            child: Stack(
              children: [
                Dismissible(
                  key: UniqueKey(),
                  direction: DismissDirection.horizontal,
                  onDismissed: (direction) {
                    String mensaje='';
                    IconData icono = Icons.error;
                    if (direction == DismissDirection.endToStart) {
                      icono = Icons.close;
                      mensaje = 'Rechazado';
                    } else if (direction == DismissDirection.startToEnd) {
                      icono = Icons.favorite;
                      mensaje = 'Me gusta';
                    }
                    mostrarIconoFlotante(context, icono, mensaje);
                    setState(() {
                      images.remove(image);
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Text(
                          userName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        images.removeAt(index);
                        mostrarIconoFlotante(context, Icons.close, 'Rechazado');
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white60,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        images.removeAt(index);
                        mostrarIconoFlotante(context, Icons.favorite, 'Me gusta');
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white60,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
      const Center(child: Text('Lista de chats con matches')),
      const Center(child: Text('Perfil del usuario')),
    ];

    final List<String> titulos = [
      'Personas',
      'Matches',
      'Perfil',
    ];

    String titulo = titulos[indiceActual];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, '/main', arguments: widget.currentUser);
            },
          ),
        ],
        title: Text(titulo),
        backgroundColor: Colors.pink,
      ),
      body: pantallas[indiceActual],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indiceActual,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.pink[100],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Personas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Matches',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        onTap: (index) {
          setState(() {
            indiceActual = index;
          });
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserProfileScreen(
                  currentUser: widget.currentUser,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
