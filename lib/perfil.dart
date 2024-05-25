import 'package:flutter/material.dart';
import 'Home.dart';
import 'settings_screen.dart';
import 'Usuario.dart';

class UserProfileScreen extends StatelessWidget {
  final Usuario user1;
  final Usuario user2;
  final Usuario user3;
  final Usuario user4;

  const UserProfileScreen({
    super.key,
    required this.user1,
    required this.user2,
    required this.user3,
    required this.user4,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Perfil'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PantallaPrincipal(
                  user1: user1,
                  user2: user2,
                  user3: user3,
                  user4: user4,
                ),
              ),
            );
          },
        ),
      ),
      body: Container(
        color: Colors.pink[300],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  const CircleAvatar(
                    radius: 155,
                    backgroundColor: Colors.black,
                  ),
                  const CircleAvatar(
                    radius: 153,
                    backgroundColor: Colors.white,
                  ),
                  CircleAvatar(
                    radius: 150,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/U1.jpg',
                        width: 300,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                user1.nombre,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Arial',
                ),
              ),
              const SizedBox(height: 32),
              _buildMenuButton(Icons.settings, 'Ajustes', context),
              _buildMenuButton(Icons.edit, 'Editar perfil', context),
              _buildMenuButton(Icons.security, 'Seguridad', context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(IconData icon, String text, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton.icon(
        icon: Icon(icon, color: Colors.black),
        label: Text(text, style: const TextStyle(color: Colors.black)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pink, // Fondo del botón
          minimumSize: const Size(200, 50), // Tamaño mínimo del botón
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(color: Colors.black, width: 1.3),
          ),
        ),
        onPressed: () {
          // Acción al presionar el botón
          if (text == 'Ajustes') {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SettingsScreen(
                      
                    )));
          } else if (text == 'Editar perfil') {
            // Navigator.push(context,MaterialPageRoute(builder: (context) => EditProfileScreen()));
          } else if (text == 'Seguridad') {
            // Navigator.push(context,MaterialPageRoute(builder: (context) => SecurityScreen()));
          }
        },
      ),
    );
  }
}
