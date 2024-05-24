import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'Usuario.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _nameError = '';
  String? _passwordError = '';

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

  Future<bool> _authenticateUser(String name, String password) async {
    final users = await _readUsers();
    if (users.containsKey(name)) {
      final user = Usuario.fromJson(users[name]);
      return user.contrasena == password;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Login'),
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
                labelStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                errorText: _nameError == '' ? null : _nameError,
                hintText: 'Introduce tu nombre de usuario',
                hintStyle: TextStyle(color: Colors.grey[600]),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                labelText: 'Contraseña',
                labelStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                errorText: _passwordError == '' ? null : _passwordError,
                hintText: 'Introduce tu contraseña',
                hintStyle: TextStyle(color: Colors.grey[600]),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 100),
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
                    final isAuthenticated = await _authenticateUser(name, password);
                    if (isAuthenticated) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Inicio de sesión exitoso'),
                        ),
                      );
                      Navigator.pop(context); // Regresar a la pantalla principal
                    } else {
                      setState(() {
                        _nameError = 'Nombre o contraseña incorrectos';
                        _passwordError = 'Nombre o contraseña incorrectos';
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Nombre o contraseña incorrectos'),
                        ),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: const StadiumBorder(
                    side: BorderSide(color: Colors.black, width: 1.5),
                  ),
                ),
                child: const Text(
                  'Iniciar Sesión',
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
