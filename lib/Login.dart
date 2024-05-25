import 'package:flutter/material.dart';
import 'Home.dart';
import 'Matches.dart';
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

   late Usuario user1;
   late Usuario user2;
   late Usuario user3;
   late Usuario user4;

  @override
  void initState() {
    super.initState();
    user1 = Usuario(
      nombre: 'Sandra',
      contrasena: '1234',
      amigo: null,
      likes: [],
      matches: [],
      chats: [],
    );
    user2 = Usuario(
      nombre: 'Maria',
      contrasena: '1234',
      amigo: null,
      likes: [],
      matches: [],
      chats: [],
    );
    user3 = Usuario(
      nombre: 'Carlos',
      contrasena: '1234',
      amigo: null,
      likes: [],
      matches: [],
      chats: [],
    );
    user4 = Usuario(
      nombre: 'Pedro',
      contrasena: '1234',
      amigo: null,
      likes: [],
      matches: [],
      chats: [],
    );

    user1.setAmigo(user2);
    user2.setAmigo(user1);
    user3.setAmigo(user4);
    user4.setAmigo(user3);

    user1.setLikes([user3]);
    user2.setLikes([user4]);
    user3.setLikes([user1]);
    user4.setLikes([user2]);

    List<Matches> matches1 = [Matches(usuarios: [user3, user4])];
    List<Matches> matches2 = [Matches(usuarios: [user1, user2])];

    user1.setMatches(matches1);
    user2.setMatches(matches1);
    user3.setMatches(matches2);
    user4.setMatches(matches2);

    user1.setChats([user2.nombre, user3.nombre, user4.nombre]);
    user2.setChats([user1.nombre, user3.nombre, user4.nombre]);
    user3.setChats([user1.nombre, user2.nombre, user4.nombre]);
    user4.setChats([user1.nombre, user2.nombre, user3.nombre]);

  }

  bool isAuthenticated(String name, String password) {
    List<Usuario> usuarios = [user1, user2, user3, user4];
    for (var usuario in usuarios) {
      if (usuario.nombre == name && usuario.contrasena == password) {
        return true;
      }
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
                    if (isAuthenticated(name, password)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Inicio de sesión exitoso'),
                        ),
                      );
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