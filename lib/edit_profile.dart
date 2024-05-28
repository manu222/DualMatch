import 'package:flutter/material.dart';
import 'package:test_app/perfil.dart';
import 'Usuario.dart';

class EditProfileScreen extends StatelessWidget {
  final Usuario? currentUser;

  const EditProfileScreen({
    super.key,
    required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Editar Perfil'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserProfileScreen(
                  currentUser: currentUser,
                ),
              ),
            );
          },
        ),
      ),
      body: Container(
        color: Colors.pink[300],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Spacer(flex: 1),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Sobre mi',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const Spacer(flex: 1),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Intereses',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const Spacer(flex: 1),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'DUO',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const Spacer(flex: 2),
            ElevatedButton(
              onPressed: () {
                /*Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsScreen(
                      currentUser: currentUser,
                    ),
                  ),
                );
                */
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, backgroundColor: Colors.pink, // Color del texto
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Padding interno
                textStyle: const TextStyle(
                  fontSize: 18,
                ),
              ),
              child: const Text('Guardar Cambios'),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
