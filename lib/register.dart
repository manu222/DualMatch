import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:test_app/UserProvider.dart';

import 'Home.dart';
import 'Usuario.dart';
import 'main.dart';

class RegisterScreen extends StatefulWidget {


  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

bool userExists(List<Usuario> usuarios, String email) {
  if (usuarios.isEmpty) {
    return usuarios.any((user) => user.email == email);
  }
  return false;
}

class _RegisterScreenState extends State<RegisterScreen> {

  String? phoneNumber;
  PhoneNumber? number;
  String? initialCountry = 'ES';


  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordControllerConfirm = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();

  String? _nameError= '';
  String? _passwordError= '';
  String? _passwordErrorConfirm= '';
  String? _emailError= '';
  String? _phoneError= '';
  String? _dateOfBirthError= '';

  @override
  void initState() {
    super.initState();
    // Omitiendo la inicialización de los usuarios de ejemplo para simplificar el código.
  }

  @override
  Widget build(BuildContext context) {

    List<Usuario>? usuarios = Provider.of<UserManager>(context).usuarios;
    Usuario? user = Provider.of<UserManager>(context).currentUser;


    if (user == null) {
      print('No hay usuario en register.dart');
    } else {
      print('Usuario: ${user.nombre}'+  ' estamos en register.dart');
    }

    if (usuarios.isEmpty) {
      print('No hay usuarios en register.dart');
    } else {
      print('Usuarios: ${usuarios.length}');
      for (var user in usuarios) {
        print('Usuario: ${user.nombre}'+  ' estamos en register.dart');
      }
    }



    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Registro'),
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
      body: SingleChildScrollView(
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
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordControllerConfirm,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                labelText: 'Confirmar contraseña',
                labelStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                errorText: _passwordErrorConfirm == '' ? null : _passwordErrorConfirm,
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
                labelStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                errorText: _emailError == '' ? null : _emailError,
              ),
            ),
            const SizedBox(height: 20),
            InternationalPhoneNumberInput(
              inputDecoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                labelText: 'Teléfono',
                labelStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                errorText: _phoneError == '' ? null : _phoneError,
              ),
              onInputChanged: (PhoneNumber number) {
                setState(() {
                  phoneNumber = number.phoneNumber;
                });
              },
              selectorConfig: const SelectorConfig(
                selectorType: PhoneInputSelectorType.DIALOG,
              ),
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.disabled,
              selectorTextStyle: const TextStyle(color: Colors.black),
              initialValue: PhoneNumber(isoCode: 'ES'),
              textFieldController: _phoneController,
              formatInput: false,
              keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
              inputBorder: const OutlineInputBorder(),
              onSaved: (PhoneNumber number) {
                print('On Saved: $number');
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _dateOfBirthController,
              readOnly: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                labelText: 'Fecha de nacimiento',
                labelStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                errorText: _dateOfBirthError == '' ? null : _dateOfBirthError,
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
                      setState(() {
                        _dateOfBirthController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
                      });
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 100),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () async {
                  final name = _nameController.text;
                  final password = _passwordController.text;
                  final passwordConfirm = _passwordControllerConfirm.text;
                  final email = _emailController.text;
                  final phone = _phoneController.text;
                  final dateOfBirth = _dateOfBirthController.text;
                  if (name.isEmpty || password.isEmpty || email.isEmpty || phone.isEmpty || dateOfBirth.isEmpty || passwordConfirm.isEmpty) {
                    setState(() {
                      _nameError = name.isEmpty ? 'Por favor, llena este campo' : '';
                      _passwordError = password.isEmpty ? 'Por favor, llena este campo' : '';
                      _passwordErrorConfirm = passwordConfirm.isEmpty ? 'Por favor, llena este campo' : '';
                      _emailError = email.isEmpty ? 'Por favor, llena este campo' : '';
                      _phoneError = phone.isEmpty ? 'Por favor, llena este campo' : '';
                      _dateOfBirthError = dateOfBirth.isEmpty ? 'Por favor, llena este campo' : '';
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Por favor, llena todos los campos'),
                      ),
                    );
                  } else if (password != passwordConfirm) {
                    setState(() {
                      _passwordError = 'Las contraseñas no coinciden';
                      _passwordErrorConfirm = 'Las contraseñas no coinciden';
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Las contraseñas no coinciden'),
                      ),
                    );
                  } else if (userExists(usuarios, email)){
                    setState(() {
                      _emailError = 'El email ya está registrado';
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('El email ya está registrado'),
                      ),
                    );
                  } else {
                    final Usuario newUser = Usuario(
                      nombre: name,
                      contrasena: password,
                      email: email,
                      bio: '',
                      intereses: [],
                      genero: '',
                      edadInicial: 0,
                      edadFinal: 0,
                      distanciaInicial: 0,
                      distanciaFinal: 0,
                      notificaciones: true,
                      privacidad: '',
                      region: '',
                      idioma: '',
                      imagenesInteligentes: true,
                      telefono: int.parse(phone),
                      amigo: null,
                      likes: [],
                      matches: [],
                      chats: [],
                    );

                    Provider.of<UserManager>(context, listen: false).addUser(newUser);
                    Provider.of<UserManager>(context, listen: false).setCurrentUser(newUser);

                    /*
                    List<Usuario> updatedUsers = List.from(widget.usuarios ?? [])..add(newUser);
                    //print lista
                    updatedUsers.forEach((element) {
                      print(element.toString());
                    });

                     */
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PantallaPrincipal(),
                      ),
                    );
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
