import 'package:flutter/material.dart';
import 'package:test_app/Home.dart';

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
              CircleAvatar(
                radius: 150,
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Image.asset(
                    'assets/U1.jpg', // Reemplaza esto con la ruta de tu imagen
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
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
              _buildMenuButton(Icons.settings, 'Ajustes'),
              _buildMenuButton(Icons.edit, 'Editar perfil'),
              _buildMenuButton(Icons.security, 'Seguridad'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(IconData icon, String text) {
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
          ),
        ),
        onPressed: () {
          // Acción al presionar el botón
        },
      ),
    );
  }
}
