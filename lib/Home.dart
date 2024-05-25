import 'package:flutter/material.dart';
import 'package:test_app/Usuario.dart';
import 'package:test_app/perfil.dart';

class PantallaPrincipal extends StatefulWidget {
  final Usuario user1;
  final Usuario user2;
  final Usuario user3;
  final Usuario user4;

  PantallaPrincipal({
    Key? key,
    required this.user1,
    required this.user2,
    required this.user3,
    required this.user4,
  }) : super(key: key);

  @override
  _PantallaPrincipalState createState() => _PantallaPrincipalState();
}

void mostrarIconoFlotante(BuildContext context, IconData icono) {
  OverlayState overlayState = Overlay.of(context);
  OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => Center(
      child: Icon(
        icono,
        color: Colors.red,
        size: 100.0,
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
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.pink.shade900),
                  ),
                ),
                SizedBox(
                  width: 110,
                  height: 110,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.pink.shade800),
                  ),
                ),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.pink.shade700),
                  ),
                ),
                SizedBox(
                  width: 90,
                  height: 90,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.pink.shade500),
                  ),
                ),
                SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.pink.shade200),
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
              userName = widget.user1.nombre;
              break;
            case 1:
              userName = widget.user2.nombre;
              break;
            case 2:
              userName = widget.user3.nombre;
              break;
            case 3:
              userName = widget.user4.nombre;
              break;
            default:
              userName = 'Usuario desconocido';
          }
          return Positioned.fill(
            child: Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.horizontal,
              onDismissed: (direction) {
                IconData icono = Icons.error;
                if (direction == DismissDirection.endToStart) {
                  icono = Icons.close;
                } else if (direction == DismissDirection.startToEnd) {
                  icono = Icons.favorite;
                }
                mostrarIconoFlotante(context, icono);
                setState(() {
                  images.remove(image);
                });
              },
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white60,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white60,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    left: 40,
                    child: Text(
                      userName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 3.0,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
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
              Navigator.pushNamed(context, '/main');
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
            icon: Icon(Icons.density_small),
            label: 'Personas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
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
                  user1: widget.user1,
                  user2: widget.user2,
                  user3: widget.user3,
                  user4: widget.user4,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
