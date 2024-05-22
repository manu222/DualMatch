import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'Usuario.dart';



class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _nameError= '';
  String? _passwordError= '';

  Future<File> _getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/users.json';
    print("-----------------------------------------------------------------------------"+path); // Imprime la ruta del archivo (opcional
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
    users[name] = Usuario(
      nombre: name,
      contrasena: password,
      likes: [],
      matches: [],
      chats: [],
    ).toJson();
    final file = await _getLocalFile();
    file.writeAsString(jsonEncode(users));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Registro'),
        backgroundColor: Colors.pink,
      ),
      backgroundColor: Colors.pink[100],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                labelText: 'Nombre',
                labelStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),
                errorText: _nameError=='' ? null : _nameError,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                labelText: 'Contraseña',
                labelStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),
                errorText: _passwordError=='' ? null : _passwordError,
              ),
              obscureText: true,
            ),
            const SizedBox(height:100),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () async {
                  final name = _nameController.text;
                  final password = _passwordController.text;
                  if (name.isEmpty || password.isEmpty) {
                    setState(() {
                      _nameError = name.isEmpty ? 'Por favor, llena este campo' : '';
                      _passwordError = password.isEmpty ? 'Por favor, llena este campo' : '';
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Por favor, llena todos los campos'),
                      ),
                    );
                  } else {
                    await _saveUser(name, password);
                    Navigator.pop(context); // Regresar a la pantalla principal
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