import 'package:flutter/material.dart';

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  _PantallaPrincipalState createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  int indiceActual = 0;
  final List<Widget> pantallas = [
    Center(child: Text('Aqui deberian ir los perfiles de las personas')),
    Center(child: Text('Lista de chats con matches')),
    Center(child: Text('perfil del usuario actual')),
  ];

  final List<String> titulos = [
    'Personas',
    'Matches',
    'Perfil',
  ];

  @override
  Widget build(BuildContext context) {

    String titulo = titulos[indiceActual];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        //boton para hacer logout
        actions: [
          IconButton(
            icon: const Icon(Icons.logout,color: Colors.white),
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
