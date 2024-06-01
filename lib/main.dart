import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'UserProvider.dart';
import 'Usuario.dart';
import 'RegisterScreen.dart';
import 'login.dart';

void main() => runApp(
  ChangeNotifierProvider(
    create: (context) => UserManager()..initializeUsers(),
    child: MyApp(),
  ),
);

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VistaInicial(),
      title: "DualMatch",
      routes: {
        '/register': (context) => RegisterScreen(),
        '/Login': (context) => Login(),
        '/main': (context) => VistaInicial(),
      },
    );
  }
}

class VistaInicial extends StatelessWidget {
  VistaInicial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Usuario>? usuarios = Provider.of<UserManager>(context).usuarios;
    Usuario? user = Provider.of<UserManager>(context).currentUser;

    if (user == null) {
      print('No hay usuario, estamos en main.dart');
    } else {
      print('Usuario: ${user.nombre}' + ' estamos en main.dart');
    }

    if (usuarios == null) {
      print('No hay usuarios, estamos en main.dart');
    } else {
      print('Usuarios: ${usuarios.length}' + ' estamos en main.dart');
      usuarios.forEach((user) {
        print('Usuario: ${user.nombre}' + ' estamos en main.dart');
      });
    }

    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image2.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '¡Bienvenido!',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 15,
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
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 15,
                        backgroundColor: Colors.pink,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: const StadiumBorder(
                          side: BorderSide(color: Colors.black, width: 1.5),
                        ),
                      ),
                      child: const Text(
                        'Registrarse',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '¡Citas dobles para el doble de diversión!',
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
