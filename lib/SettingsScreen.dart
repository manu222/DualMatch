import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'UserProvider.dart';
import 'Usuario.dart';

class SettingsScreen extends StatefulWidget {


   SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _switchValue = false;




  List<String> comunidadesAutonomas = [
    'Andalucía', 'Aragón', 'Asturias', 'Baleares', 'Canarias', 'Cantabria',
    'Castilla y León', 'Castilla-La Mancha', 'Cataluña', 'Comunidad Valenciana',
    'Extremadura', 'Galicia', 'Madrid', 'Murcia', 'Navarra', 'País Vasco',
    'La Rioja', 'Ceuta', 'Melilla'
  ];
  //edades de 18 a 100
  List<int> edades = [for (int i = 18; i <= 100; i += 1) i];

  @override
  Widget build(BuildContext context) {

    List<Usuario>? usuarios = Provider.of<UserManager>(context).usuarios;
    Usuario? currentUser = Provider.of<UserManager>(context).currentUser;

    if (currentUser == null) {
      print('No hay usuario estamos en SettingsScreen.dart');
    } else {
      print('Usuario: ${currentUser.nombre}' + ' estamos en SettingsScreen.dart');
    }

    for (Usuario user in usuarios) {
      print('Usuario: ${user.nombre}' ' estamos en SettingsScreen.dart');
    }

    double _currentSliderValue = 1;


    Widget _buildSlider(String label, IconData icon) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, color: Colors.black),
                    const SizedBox(width: 8),
                    Text(
                      label,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Slider(
              value: currentUser!.distanciaFinal!.toDouble() ?? _currentSliderValue,
              min: 0,
              max: 200,
              divisions: 200,
              label: currentUser.distanciaFinal.toString() ?? _currentSliderValue.toString() ,
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value ;
                  currentUser.distanciaFinal = value.toInt();
                  print(currentUser.distanciaFinal);
                });
              },
            ),
            Text(
              currentUser.distanciaFinal.toString()+' km' ?? _currentSliderValue.toString() + ' km',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }






    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Ajustes de perfil'),
        centerTitle: true,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Divider(color: Colors.white, thickness: 1,),
              _buildDropdown('Género', ['Mujer', 'Hombre', 'Otro'],Icons.person),
              const Divider(color: Colors.white, thickness: 1,),
              _buildRangeSlider('Edades', Icons.calendar_month,),
              const Divider(color: Colors.white, thickness: 1,),
              _buildSlider('Distancia', Icons.location_on),
              const Divider(color: Colors.white, thickness: 1,),
              _buildToggleSwitch('Notificaciones', Icons.notifications_active, currentUser!),
              const Divider(color: Colors.white, thickness: 1 ,),
              _buildDropdown('Privacidad', ['Público', 'Privado'],Icons.lock),
              const Divider(color: Colors.white, thickness: 1,),
              _buildDropdown('Región', comunidadesAutonomas,Icons.location_city),
              const Divider(color: Colors.white, thickness: 1,),
              _buildDropdown('Idioma', ['Español', 'Inglés', 'Francés','Portugués'],Icons.language),
              const Divider(color: Colors.white, thickness: 1,),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Cambios guardados')),
                  );
                  print('Cambios guardados');
                },
                child: const Text('Guardar cambios'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.pink, // Cambia el color del texto aquí
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(color: Colors.black, width: 1.3),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  RangeValues _currentRangeValues = const RangeValues(18, 100);
  Widget _buildRangeSlider(String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: Colors.black),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
          RangeSlider(
            values: _currentRangeValues,
            min: 18,
            max: 100,
            divisions: 82,
            labels: RangeLabels(
              _currentRangeValues.start.round().toString(),
              _currentRangeValues.end.round().toString(),
            ),
            onChanged: (RangeValues values) {
              if (values.end >= values.start) {
                setState(() {
                  _currentRangeValues = values;
                });
              }
            },
          ),
          Text(
            'De ${_currentRangeValues.start.round()} a ${_currentRangeValues.end.round()} años',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown<T>(String label, List<T> options, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(  // Agrega este Row
            children: [
              Icon(icon, color: Colors.black),  // Agrega este Icon
              const SizedBox(width: 8),  // Agrega este SizedBox para dar un poco de espacio entre el icono y el texto
              Text(
                label,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          DropdownButton<T>(
            value: options[0],
            items: options.map((T value) {
              return DropdownMenuItem<T>(
                value: value,
                child: Text(value.toString()),
              );
            }).toList(),
            onChanged: (T? newValue) {},
            dropdownColor: Colors.white,
            style: const TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }


  Widget _buildToggleSwitch(String label, IconData icon, Usuario currentUser) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.black),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Switch(
            value: currentUser.notificaciones ?? false,
            onChanged: (bool newValue) {
              setState(() {
                currentUser.notificaciones = newValue;
              });
            },
            activeColor: Colors.green,
            inactiveThumbColor: Colors.red,
          ),
        ],
      ),
    );
  }
}
