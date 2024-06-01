import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/UserProvider.dart';
import 'package:test_app/Usuario.dart';
import 'package:test_app/UserProfileScreen.dart';
import 'main.dart';
import 'Matches.dart';  // Importa la nueva pantalla

class PantallaPrincipal extends StatefulWidget {
  PantallaPrincipal({super.key,});

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
            style: const TextStyle(color: Colors.red, fontSize: 24),
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

  @override
  void initState() {
    super.initState();
  }

  final List<String> images = [
    'assets/U1.jpg',
    'assets/U2.jpg',
    'assets/U3.jpg',
    'assets/U4.jpg',
  ];

  final List<String> titulos = [
    'Personas',
    'Matches',
    'Perfil',
  ];

  @override
  Widget build(BuildContext context) {
    List<Usuario> usuarios = Provider.of<UserManager>(context).usuarios;
    Usuario? currentUser = Provider.of<UserManager>(context).currentUser;

    Usuario user1 = usuarios[0];
    Usuario user2 = usuarios[1];
    Usuario user3 = usuarios[2];
    Usuario user4 = usuarios[3];

    if (currentUser == null) {
      print('No hay usuario estamos en home.dart');
    } else {
      print('Usuario: ${currentUser.nombre}'' estamos en PantallaPrincipal.dart');
    }

    print('Usuarios: ${usuarios.length}');
    for (Usuario user in usuarios) {
      print('Usuario: ${user.nombre}'' estamos en PantallaPrincipal.dart');
    }

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
          String? Bio;
          switch (index) {
            case 0:
              userName = user1.nombre;
              Bio = user1.bio;
              break;
            case 1:
              userName = user2.nombre;
              Bio = user2.bio;
              break;
            case 2:
              userName = user3.nombre;
              Bio = user3.bio;
              break;
            case 3:
              userName = user4.nombre;
              Bio = user4.bio;
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
                      mensaje = 'No me gusta';
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
                          '$userName' ':'
                              '\n$Bio',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
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

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Provider.of<UserManager>(context, listen: false).logout();
              Navigator.push(context, MaterialPageRoute(builder: (context) => VistaInicial()));
            },
          ),
        ],
        title: Text(titulos[indiceActual]),
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
                builder: (context) => UserProfileScreen(),
              ),
            );
          }
          // Nueva navegación a ChatIndividual
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Matches(),
              ),
            );
          }
        },
      ),
    );
  }
}
