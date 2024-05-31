import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test_app/perfil.dart';

import 'UserProvider.dart';
import 'Usuario.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _isError = false;
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _duoController = TextEditingController();

  final List<String> _interests = [
    'Interfaces de usuario =)',
    'Amor',
    'Amistad',
    'Anime',
    'Comida',
    'Deporte',
    'Películas',
    'Series',
    'Viajes',
    'Videojuegos',
    'Música',
    'Lectura',
    'Bailar',
    'Cantar',
    'Dibujar',
    'Cocinar',
    'Programar',
    'Fotografía',
    'Moda',
    'Tecnología',
    'Ciencia',
    'Historia',
    'Arte',
    'Naturaleza',
    'Animales',
    'Política',
    'Economía',
    'Negocios',
    'Educación',
    'Salud',
    'Mente',
    'Cuerpo',
    'Espiritualidad',
    'Religión',
    'Familia',
  ];

  List<String> _selectedInterests = [];
  bool _smartPhotosEnabled = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Usuario? currentUser = Provider.of<UserManager>(context, listen: false).currentUser;

      if (currentUser != null) {
        _bioController.text = currentUser.bio ?? '';
        _selectedInterests = currentUser.intereses ?? [];
        _smartPhotosEnabled = currentUser.imagenesInteligentes ?? true;
        _duoController.text = currentUser.amigo?.email ?? '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Usuario? currentUser = Provider.of<UserManager>(context).currentUser;

    if (currentUser == null) {
      print('No hay usuario actual en edit_profile.dart');
    } else {
      print('Usuario: ${currentUser.nombre} en edit_profile.dart');
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text('Editar Perfil'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserProfileScreen(),
              ),
            );
          },
        ),
      ),
      body: Container(
        color: Colors.pink[300],
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Opciones de foto:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Switch(
                  value: _smartPhotosEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      _smartPhotosEnabled = value;
                    });
                  },
                  activeColor: Colors.green,
                ),
              ],
            ),
            const Text(
              'Fotos inteligentes evalúa continuamente todas tus fotos de perfil para encontrar la mejor de todas ellas.',
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 32.0),
            TextField(
              controller: _bioController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Descripción',
                labelStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                errorText: _bioController.text.isEmpty ? 'Por favor, llena este campo' : null,
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16.0),
            MultiSelectDialogField(
              items: _interests
                  .map((interest) => MultiSelectItem<String>(interest, interest))
                  .toList(),
              title: const Text("Intereses"),
              searchable: true,
              searchHint: 'Buscar intereses',
              selectedColor: Colors.pink,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              buttonIcon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
              ),
              buttonText: const Text(
                "Seleccionar Intereses",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              initialValue: _selectedInterests,
              onConfirm: (results) {
                setState(() {
                  _selectedInterests = results.cast<String>();
                });
              },
            ),
            const SizedBox(height: 16.0),
            Text(
              'Tus intereses: ${_selectedInterests.join(', ')}',
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _duoController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _isError ? Colors.red : Colors.grey,
                  ),
                ),
                labelText: 'DUO (correo de tu amigo)',
                filled: true,
                fillColor: Colors.white,
                labelStyle: const TextStyle(color: Colors.black),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      _duoController.clear();
                      currentUser?.amigo = null;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Si tienes un amigo que también usa la app, puedes agregar su correo aquí para que puedan ser DUO.',
              style: TextStyle(color: Colors.black),
            ),
            const Text(
              'Si no tienes un amigo, puedes dejar este campo vacío.',
              style: TextStyle(color: Colors.black),
            ),
            Text(
              'DUO actual: ${currentUser?.amigo?.email ?? 'No tienes DUO'}',
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                String bio = _bioController.text.trim();
                String duo = _duoController.text.trim();
                bool smartPhotos = _smartPhotosEnabled;

                if (bio.isEmpty) {
                  setState(() {
                    _isError = true;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Por favor, llena el campo de descripción.')),
                  );
                  return;
                }

                Usuario? currentUser = Provider.of<UserManager>(context, listen: false).currentUser;
                if (currentUser != null) {
                  currentUser.setBio(bio);
                  currentUser.intereses = _selectedInterests;
                  currentUser.imagenesInteligentes = smartPhotos;

                  if (duo.isNotEmpty && duo != currentUser.email) {
                    Usuario? amigo = await Provider.of<UserManager>(context, listen: false).getUsuarioByEmail(duo);
                    if (amigo == null) {
                      setState(() {
                        _isError = true;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("No se encontró el usuario, pero se guardaron el resto de los cambios.")),
                      );
                    } else {
                      currentUser.amigo = amigo;
                    }
                  } else if (duo == currentUser.email) {
                    setState(() {
                      _isError = true;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("No puedes ser tu propio amigo, pero se guardaron el resto de los cambios.")),
                    );
                  } else {
                    currentUser.amigo = null;
                  }

                  print(currentUser.nombre);
                  print(currentUser.bio);
                  print(currentUser.toString());
                  print(currentUser.amigo?.nombre);
                }

                setState(() {
                  _isError = false;
                });
              },
              child: const Text('Guardar cambios'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.pink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: const BorderSide(color: Colors.black, width: 1.3),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
