import 'package:flutter/material.dart';
import 'register.dart';
import 'login.dart';
import 'Home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const VistaInicial(),
      routes: {
        '/register': (context) => const RegisterScreen(),
        '/Login': (context) => const Login(),
        '/Home': (context) => PantallaPrincipal(),
        '/main': (context) => const VistaInicial(),
      },
    );
  }
}

class VistaInicial extends StatelessWidget {
  const VistaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100], // Color de fondo de la pantalla
      body: Column(
        children: [
          // Imagen de fondo en la mitad superior
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image2.png'), // Asegúrate de colocar la imagen en la carpeta assets
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Contenido principal en la mitad inferior
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Título
                const Text(
                  '¡Bienvenido!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),
                ),
                const SizedBox(height: 20),
                // Botón de Iniciar Sesión
                SizedBox(
                  width: 200, // Ancho fijo para los botones
                  child: ElevatedButton(
                    onPressed: () {
                      // Acción de iniciar sesión
                      Navigator.pushNamed(context, '/Login');
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 15, // Elevación del botón
                      backgroundColor: Colors.pink, // Color de fondo del botón
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: const StadiumBorder(
                        side: BorderSide(color: Colors.black, width: 1.5),
                      )
                    ),
                    child: const Text(
                      'Iniciar Sesión',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Botón de Registrarse
                SizedBox(
                  width: 200, // Ancho fijo para los botones
                  child: ElevatedButton(
                    onPressed: () {
                      // Navegar a la pantalla de registro
                      Navigator.pushNamed(context, '/register');
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 15, // Elevación del botón
                      backgroundColor: Colors.pink, // Color de fondo del botón
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: const StadiumBorder(
                        side: BorderSide(color: Colors.black, width: 1.5),
                      )
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
        ],
      ),
    );
  }
}
