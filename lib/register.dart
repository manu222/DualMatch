import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:test_app/UserHelper.dart';

import 'Home.dart';
import 'Matches.dart';
import 'Usuario.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  String? phoneNumber;
  PhoneNumber? number;
  String? initialCountry = 'ES';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();

  String? _nameError= '';
  String? _passwordError= '';
  String? _emailError= '';
  String? _phoneError= '';
  String? _dateOfBirthError= '';

  late Usuario user1;
  late Usuario user2;
  late Usuario user3;
  late Usuario user4;

  @override
  void initState() {
    super.initState();
    user1 = Usuario(
      nombre: 'user1',
      contrasena: '1234',
      email: '',
      telefono: 0,
      amigo: null,
      likes: [],
      matches: [],
      chats: [],
    );
    user2 = Usuario(
      nombre: 'user2',
      contrasena: '1234',
      email: '',
      telefono: 0,
      amigo: null,
      likes: [],
      matches: [],
      chats: [],
    );
    user3 = Usuario(
      nombre: 'user3',
      contrasena: '1234',
      email: '',
      telefono: 0,
      amigo: null,
      likes: [],
      matches: [],
      chats: [],
    );
    user4 = Usuario(
      nombre: 'user4',
      contrasena: '1234',
      email: '',
      telefono: 0,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Registro'),
        backgroundColor: Colors.pink,
      ),
      backgroundColor: Colors.pink[100],
      body: SingleChildScrollView( // Agregado aquí
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
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                labelText: 'Correo',
                labelStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),
                errorText: _emailError=='' ? null : _emailError,
              ),
            ),
            const SizedBox(height: 20),

            InternationalPhoneNumberInput(
              inputDecoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                labelText: 'Teléfono',
                labelStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),
                errorText: _phoneError=='' ? null : _phoneError,
              ),
              onInputChanged: (PhoneNumber number) {
                print(number.phoneNumber);
                phoneNumber = number.phoneNumber;
              }, // Cierra el método onInputChanged
              onInputValidated: (bool value) {
                print(value);
              }, // Cierra el método onInputValidated
              selectorConfig: SelectorConfig(
                selectorType: PhoneInputSelectorType.DIALOG,
              ), // Cierra el widget SelectorConfig
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.disabled,
              selectorTextStyle: TextStyle(color: Colors.black),
              initialValue: number,
              textFieldController: _phoneController,
              formatInput: false,
              keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
              inputBorder: OutlineInputBorder(),
              onSaved: (PhoneNumber number) {
                print('On Saved: $number');
              }, // Cierra el método onSaved
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _dateOfBirthController,
              readOnly: true, // Hace que el campo de texto sea de solo lectura
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                labelText: 'Fecha de nacimiento',
                labelStyle: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15),
                errorText: _dateOfBirthError=='' ? null : _dateOfBirthError,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    final DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      _dateOfBirthController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height:100),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () async {
                  final name = _nameController.text;
                  final password = _passwordController.text;
                  final email = _emailController.text;
                  final phone = _phoneController.text;
                  final dateOfBirth = _dateOfBirthController.text;
                  if (name.isEmpty || password.isEmpty || email.isEmpty || phone.isEmpty || dateOfBirth.isEmpty) {
                    setState(() {
                      _nameError = name.isEmpty ? 'Por favor, llena este campo' : '';
                      _passwordError = password.isEmpty ? 'Por favor, llena este campo' : '';
                      _emailError = email.isEmpty ? 'Por favor, llena este campo' : '';
                      _phoneError = phone.isEmpty ? 'Por favor, llena este campo' : '';
                      _dateOfBirthError = dateOfBirth.isEmpty ? 'Por favor, llena este campo' : '';
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Por favor, llena todos los campos'),
                      ),
                    );
                  } else {
                    Usuario newUser = Usuario(
                      nombre: name,
                      contrasena: password,
                      email: email,
                      telefono: int.parse(phone),
                      amigo: null,
                      likes: [],
                      matches: [],
                      chats: [],
                    );
                    if (await UserHelper.existsUser(newUser.email)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('El usuario ya existe'),
                        ),
                      );
                      return;
                    }else{

                      await UserHelper.saveUser(newUser);

                      List<Usuario> users = await UserHelper.getUsers();
                      Usuario? savedUser = await UserHelper.getSpecificUser(email) as Usuario?;
                      if (savedUser != null) {
                        print('Usuario recuperado: ${savedUser.nombre}');
                        print('Email: ${savedUser.email}');
                        print('Telefono: ${savedUser.telefono}');

                      } else {
                        print('No se pudo recuperar el usuario');
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Usuario registrado con éxito'),
                        ),
                      );
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PantallaPrincipal(
                          currentUser: newUser,
                        ),
                      ),
                    );
                     // Regresar a la pantalla principal
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