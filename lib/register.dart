import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/users.json';
    final file = File(path);
    file.createSync(recursive: true);
    return file;
  }

  Future<Map<String, dynamic>> _readUsers() async {
    try {
      final file = await _getLocalFile();
      String contents = await file.readAsString();
      return jsonDecode(contents);
    } catch (e) {
      return {};
    }
  }

  Future<void> _saveUser(String name, String password) async {
    final users = await _readUsers();
    users[name] = {
      'password': password,
      'matches': [],
      'chats': [],
    };
    final file = await _getLocalFile();
    file.writeAsString(jsonEncode(users));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100], // Mismo color de fondo que en main.dart
      appBar: AppBar(
        title: const Text('Registrarse'),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
            child: ElevatedButton(
              onPressed: () async {
                final name = _nameController.text;
                final password = _passwordController.text;
                if (name.isNotEmpty && password.isNotEmpty) {
                  await _saveUser(name, password);
                  Navigator.pop(context); // Regresar a la pantalla principal
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Por favor, llena todos los campos'),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink, // Color del botón
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text(
                'Registrarse',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}
