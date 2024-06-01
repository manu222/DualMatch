import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/Home.dart';
import 'package:test_app/Usuario.dart';

import 'UserProvider.dart';
import 'main.dart';

class Login extends StatefulWidget {


  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _emailError = '';
  String? _passwordError = '';


  @override
  Widget build(BuildContext context) {

    List<Usuario>? usuarios = Provider.of<UserManager>(context).usuarios;
    Usuario? user = Provider.of<UserManager>(context).currentUser;

    if (user == null) {
      print('No hay usuario estamos en login.dart');
    } else {
      print('Usuario: ${user.nombre}'+  ' estamos en login.dart');
    }

    print('Usuarios: ${usuarios.length}');
    for (Usuario user in usuarios) {
      print('Usuario: ${user.nombre}'+' estamos en login.dart');
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Login'),
        backgroundColor: Colors.pink,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => VistaInicial(),
              ),
            );
          },
        ),
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
                labelStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
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
                labelStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
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

                    // Verificar la autenticación del usuario
                    Usuario? authenticatedUser;
                    bool userExists = false;

                    if (usuarios != null) {
                      int i = 0;
                      while (i < usuarios.length && !userExists) {
                        if (usuarios[i].email == email && usuarios[i].getPassword() == password) {
                          userExists = true;
                          authenticatedUser = usuarios[i];
                        }
                        i++;
                      }

                    }

                    if (userExists) {
                      Provider.of<UserManager>(context, listen: false).setCurrentUser(authenticatedUser!);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PantallaPrincipal(),
                        ),
                      );
                    } else {

                      setState(() {
                        _emailError = 'Email o contraseña incorrectos';
                        _passwordError = 'Email o contraseña incorrectos';

                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Email o contraseña incorrectos'),
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
