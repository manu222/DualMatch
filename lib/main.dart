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
)
);

class MyApp extends StatefulWidget {


   MyApp({super.key});

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


  VistaInicial({super.key});

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
                      color: Colors.black),
                ),
                const SizedBox(height: 20),
                // Botón de Iniciar Sesión
                SizedBox(
                  width: 200, // Ancho fijo para los botones
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
                        elevation: 15, // Elevación del botón
                        backgroundColor: Colors.pink, // Color de fondo del botón
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: const StadiumBorder(
                          side: BorderSide(color: Colors.black, width: 1.5),
                        )),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 15, // Elevación del botón
                        backgroundColor: Colors.pink, // Color de fondo del botón
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: const StadiumBorder(
                          side: BorderSide(color: Colors.black, width: 1.5),
                        )),
                    child: const Text(
                      'Registrarse',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('¡Citas dobles para el doble de diversión!',
                    style: TextStyle(fontSize: 12, color: Colors.black)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
