import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:test_app/perfil.dart';
import 'Matches.dart';
import 'UserHelper.dart';
import 'Usuario.dart';

class EditProfileScreen extends StatefulWidget {
  final Usuario? currentUser;


   EditProfileScreen({
    Key? key, this.currentUser
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
  late Usuario user1;
  late Usuario user2;
  late Usuario user3;
  late Usuario user4;

  @override
  void initState() {
    super.initState();
    user1 = Usuario(
      nombre: 'Sandra',
      contrasena: '1234',
      email: 'sandra@gmail.com',
      bio: 'Hola, soy Sandra, me gusta el cine y la música',
      intereses: ['Cine', 'Música'],
      genero: 'Femenino',
      edadInicial: 18,
      edadFinal: 30,
      distanciaInicial: 0,
      distanciaFinal: 10,
      notificaciones: true,
      privacidad: 'Público',
      region: 'España',
      idioma: 'Español',
      imagenesInteligentes: true,
      telefono: 1234567890,
      amigo: null,
      likes: [],
      matches: [],
      chats: [],
    );
    user2 = Usuario(
      nombre: 'Maria',
      contrasena: '1234',
      email: 'maria@gmail.com',
      bio: 'Hola, soy Maria, me gusta el deporte y la lectura',
      intereses: ['Deporte', 'Lectura'],
      genero: 'Femenino',
      edadInicial: 18,
      edadFinal: 30,
      distanciaInicial: 0,
      distanciaFinal: 10,
      notificaciones: true,
      privacidad: 'Público',
      region: 'España',
      idioma: 'Español',
      imagenesInteligentes: true,
      telefono: 1234567890,
      amigo: null,
      likes: [],
      matches: [],
      chats: [],
    );
    user3 = Usuario(
      nombre: 'Carlos',
      contrasena: '1234',
      email: 'carlos@gmail.com',
      bio: 'Hola, soy Carlos, me gusta la música y el cine',
      intereses: ['Música', 'Cine'],
      genero: 'Masculino',
      edadInicial: 18,
      edadFinal: 30,
      distanciaInicial: 0,
      distanciaFinal: 10,
      notificaciones: true,
      privacidad: 'Público',
      region: 'España',
      idioma: 'Español',
      imagenesInteligentes: true,
      telefono: 1234567890,
      amigo: null,
      likes: [],
      matches: [],
      chats: [],
    );
    user4 = Usuario(
      nombre: 'Pedro',
      contrasena: '1234',
      email: 'pedro@mail.com',
      bio: 'Hola, soy Pedro, me gusta el deporte y la lectura',
      intereses: ['Deporte', 'Lectura'],
      genero: 'Masculino',
      edadInicial: 18,
      edadFinal: 30,
      distanciaInicial: 0,
      distanciaFinal: 10,
      notificaciones: true,
      privacidad: 'Público',
      region: 'España',
      idioma: 'Español',
      imagenesInteligentes: true,
      telefono: 1234567890,
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

    widget.currentUser!.setMatches(matches2);
    widget.currentUser!.setChats([user1.nombre, user2.nombre, user3.nombre, user4.nombre]);
    widget.currentUser!.setAmigo(user3);
    _bioController.text = widget.currentUser!.bio ?? '';
    _selectedInterests = widget.currentUser!.intereses ?? [];
    _smartPhotosEnabled = widget.currentUser!.imagenesInteligentes ?? true;
    _duoController.text = widget.currentUser!.amigo?.email ?? '';
    _smartPhotosEnabled = widget.currentUser!.imagenesInteligentes ?? true;

    List<Usuario> users = [user1, user2, user3, user4];

  }

  @override
  Widget build(BuildContext context) {
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
                builder: (context) => UserProfileScreen(
                  currentUser: widget.currentUser,
                ),
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
              searchable: true, // Habilitar búsqueda
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
              onConfirm: (results) {
                setState(() {
                  _selectedInterests = results.cast<String>();
                });
              },
            ),
            const SizedBox(height: 16.0),
            Text('Tus intereses: ${_selectedInterests.join(', ')}',
                style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16.0)),
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
                      widget.currentUser!.amigo = null;
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
            const Text('Si no tienes un amigo, puedes dejar este campo vacío.',
                style: TextStyle(color: Colors.black)),
            Text('DUO actual: ${widget.currentUser!.amigo?.email ?? 'No tienes DUO'}',
                style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16.0)
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                //quiero actualizar los datos del usuario actual tanto en la lista de usuarios como en los datos actuales
                String bio = _bioController.text;
                String duo = _duoController.text;
                bool smartPhotos = _smartPhotosEnabled;

                widget.currentUser!.bio = bio;
                widget.currentUser!.intereses = _selectedInterests;
                widget.currentUser!.imagenesInteligentes = smartPhotos;

                Usuario? amigo = await UserHelper.getSpecificUser(_duoController.text);
                if (amigo?.email == "" && _duoController.text.isNotEmpty || user1.email!=_duoController.text || user2.email!=_duoController.text || user3.email!=_duoController.text || user4.email!=_duoController.text) {
                  setState(() {
                    _isError = true;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("No se encontró el usuario, pero se guardaron el resto de los cambios."))
                  );
                }else if(_duoController.text==widget.currentUser!.email){
                  setState(() {
                    _isError = true;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("No puedes ser tu propio amigo, pero se guardaron el resto de los cambios."))
                  );
                }else{
                  widget.currentUser?.amigo = amigo;

                }

                UserHelper.saveSpecificUser(widget.currentUser!);
                print(widget.currentUser!.nombre);
                print(widget.currentUser!.bio);
                print(widget.currentUser!.toString());
                print(widget.currentUser!.amigo?.nombre);

/*
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserProfileScreen(
                      currentUser: widget.currentUser,
                    ),
                  ),
                );

 */
              },
              child: const Text('Guardar cambios'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.pink,
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
