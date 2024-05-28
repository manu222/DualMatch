import 'package:flutter/material.dart';
import 'Home.dart';
import 'edit_profile.dart';
import 'settings_screen.dart';
import 'Usuario.dart';

class UserProfileScreen extends StatelessWidget {
  final Usuario? currentUser;

  const UserProfileScreen({
    super.key,
    required this.currentUser,
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
                  currentUser: currentUser,
                ),
              ),
            );
          },
        ),
      ),
      body: Container(
        color: Colors.pink[300],
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
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
                      backgroundColor: Colors.grey,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/icon.png',
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
                  currentUser!.nombre,
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
                const SizedBox(height: 32),
              ],
            ),
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
                    builder: (context) => SettingsScreen()));
          } else if (text == 'Editar perfil') {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditProfileScreen(
                      currentUser: currentUser,
                    )));
          } else if (text == 'Seguridad') {
            // Navigator.push(context,MaterialPageRoute(builder: (context) => SecurityScreen()));
          }
        },
      ),
    );
  }
}
