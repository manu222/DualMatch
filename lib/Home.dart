import 'package:flutter/material.dart';
import 'package:test_app/Usuario.dart';

class PantallaPrincipal extends StatefulWidget {

  Usuario user1;
  Usuario user2;
  Usuario user3;
  Usuario user4;

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
  Future.delayed(Duration(milliseconds: 500), () {
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
        ? Center(child: Text('No hay personas disponibles'))
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
              IconData icono = Icons.error; // Icono por defecto
              if (direction == DismissDirection.endToStart) {
                icono = Icons.close; // Icono de 'No me gusta'
              } else if (direction == DismissDirection.startToEnd) {
                icono = Icons.favorite; // Icono de 'Me gusta'
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
            ),
          ),
        );
      }).toList(),
    ),
      Center(child: Text('Lista de chats con matches')),
      Center(child: Text('Perfil del usuario actual')),
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
        },
      ),
    );
  }
}
