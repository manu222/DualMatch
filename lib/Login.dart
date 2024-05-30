import 'package:flutter/material.dart';
import 'package:test_app/UserHelper.dart';
import 'Home.dart';
import 'Usuario.dart';

class Login extends StatefulWidget {
  final Usuario? user;
  List<Usuario>? usuarios;

  Login({super.key, this.user, this.usuarios});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _emailError = '';
  String? _passwordError = '';

  Future<bool> isAuthenticated(String email, String password) async {
    Usuario? user = await UserHelper.getUserByMailAndPassword(email, password);
    return user != null;
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
              controller: _emailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                labelText: 'Email',
                labelStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                errorText: _emailError == '' ? null : _emailError,
                hintText: 'Introduce tu email',
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
                  final email = _emailController.text;
                  final password = _passwordController.text;
                  if (email.isEmpty || password.isEmpty) {
                    setState(() {
                      _emailError = email.isEmpty ? 'Por favor, llena este campo' : '';
                      _passwordError = password.isEmpty ? 'Por favor, llena este campo' : '';
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Por favor, llena todos los campos'),
                      ),
                    );
                  } else {
                    if (await UserHelper.existsUser(email)) {
                      if (await isAuthenticated(email, password)) {
                        Usuario? currentUser = await UserHelper.getUserByMailAndPassword(email, password);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PantallaPrincipal(currentUser: currentUser, usuarios: widget.usuarios),
                          ),
                        );
                      } else {
                        setState(() {
                          _passwordError = 'Contraseña incorrecta';
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Email o contraseña incorrectos'),
                          ),
                        );
                      }
                    } else {
                      setState(() {
                        _emailError = 'El usuario no existe';
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('El usuario no existe'),
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
