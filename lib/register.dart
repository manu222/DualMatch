import 'package:flutter/material.dart';



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
                    Navigator.pop(context); // Regresar a la pantalla principal
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink, // Color del botón
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
    );
  }
}