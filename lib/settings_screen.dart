import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {

  const SettingsScreen({Key? key}) : super(key: key);

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
  List<int> edades = [18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
    31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48,
    49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66,
    67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84,
    85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Ajustes de perfil'),
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
              _buildRangeSlider('Edades', Icons.calendar_month),
              const Divider(color: Colors.white, thickness: 1,),
              _buildSlider('Distancia', Icons.location_on),
              const Divider(color: Colors.white, thickness: 1,),
              _buildToggleSwitch('Notificaciones', Icons.notifications_active),
              const Divider(color: Colors.white, thickness: 1 ,),
              _buildDropdown('Privacidad', ['Público', 'Privado'],Icons.lock),
              const Divider(color: Colors.white, thickness: 1,),
              _buildDropdown('Región', comunidadesAutonomas,Icons.location_city),
              const Divider(color: Colors.white, thickness: 1,),
              _buildDropdown('Idioma', ['Español', 'Inglés', 'Francés','Portugués'],Icons.language),
              const Divider(color: Colors.white, thickness: 1,),
            ],
          ),
        ),
      ),
    );
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
            value: _currentSliderValue,
            min: 0,
            max: 200,
            divisions: 200,
            label: _currentSliderValue.round().toString(),
            onChanged: (double value) {
              setState(() {
                _currentSliderValue = value ;
              });
            },
          ),
          Text(
            '${_currentSliderValue.round()} km',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ],
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


   Widget _buildToggleSwitch(String label,IconData icon) {
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
             value: _switchValue,
             onChanged: (bool newValue) {
               setState(() {
                 _switchValue = newValue;
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
