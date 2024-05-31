import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:test_app/main.dart';

import 'UserProvider.dart';
import 'Usuario.dart';

class SecurityScreen extends StatefulWidget {
   SecurityScreen({super.key});

  @override
  _SecurityScreenState createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  String? phoneNumber;
  final TextEditingController _phoneController = TextEditingController();

  // Función para mostrar el diálogo de notificación
  void showNotificationDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Simulación de notificación"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text("Cerrar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    List<Usuario>? usuarios = Provider.of<UserManager>(context).usuarios;
    Usuario? currentUser = Provider.of<UserManager>(context).currentUser;

    if (currentUser == null) {
      print('No hay usuario estamos en SecurityScreen.dart');
    } else {
      print('Usuario: ${currentUser.nombre}' ' estamos en SecurityScreen.dart');
    }

    for (Usuario user in usuarios) {
      print('Usuario: ${user.nombre}' ' estamos en SecurityScreen.dart');
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.pink,
        title: const Text('Seguridad'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.pink[300],
        child: Center(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Autenticación de dos factores:',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Introduce tu teléfono',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: InternationalPhoneNumberInput(
                        inputDecoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Teléfono',
                          labelStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onInputChanged: (PhoneNumber number) {
                          setState(() {
                            phoneNumber = number.phoneNumber ?? '';
                            //Quita los 3 primeros caracteres
                            if(phoneNumber!.length > 3){
                              phoneNumber = phoneNumber!.substring(3);
                            }
                            currentUser!.telefono = int.parse(phoneNumber!);
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
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
                        inputBorder: const OutlineInputBorder(),
                        onSaved: (PhoneNumber number) {
                          print('On Saved: $number');
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          // Lógica para manejar el número de teléfono enviado
                          if (phoneNumber != null && phoneNumber!.isNotEmpty) {
                            showNotificationDialog("Se ha enviado una notificación al número: $phoneNumber");
                          } else {
                            showNotificationDialog("Por favor, introduce un número de teléfono válido.");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink, // Background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: const BorderSide(color: Colors.black, width: 1.5),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                        ),
                        child: const Text('Enviar', style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          // Acción al cerrar sesión
                          Provider.of<UserManager>(context, listen: false).logout();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VistaInicial(),
                            ),
                          );

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink, // Background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: const BorderSide(color: Colors.black, width: 1.5),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                        ),
                        child: const Text('Cerrar sesión', style: TextStyle(color: Colors.black)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          // Acción al eliminar cuenta
                          Provider.of<UserManager>(context, listen: false).removeUsuario(currentUser!);
                          Provider.of<UserManager>(context, listen: false).logout();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VistaInicial(),
                            ),
                          );

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink, // Background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: const BorderSide(color: Colors.black, width: 1.5),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                        ),
                        child: const Text('Eliminar cuenta', style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
