import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'Usuario.dart'; // Asegúrate de importar tu clase User

class UserHelper {

  static Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/users.json');
  }

  static Future<bool> existsUser(String email) async{
    List<Usuario> users = await getUsers();
    return users.any((user) => user.email == email);
  }

  static Future<Usuario?> getUserByMailAndPassword(String email, String password) async {
    List<Usuario> users = await getUsers();
    Usuario? user = users.firstWhere(
          (user) => user.email == email && user.contrasena == password,
      orElse: () => Usuario(nombre: "", contrasena: "", telefono: 0, email: email, likes: [], matches: [], chats: []),
    );
    return user;
  }


  static Future<bool> saveUser(Usuario user) async {
    try {
      final file = await _getFile();
      List<Usuario> users = await getUsers();
      users.add(user);
      final jsonString = jsonEncode(users.map((user) => user.toJson()).toList());
      await file.writeAsString(jsonString);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<List<Usuario>> getUsers() async {
    try {
      final file = await _getFile();
      if (!file.existsSync()) {
        return [];
      }
      final jsonString = await file.readAsString();
      final List<dynamic> userMaps = jsonDecode(jsonString);
      return userMaps.map((userMap) => Usuario.fromJson(userMap)).toList();
    } catch (e) {
      return [];
    }
  }

  static Future<Usuario?> getSpecificUser(String email) async {
    List<Usuario> users = await UserHelper.getUsers();

    Usuario? specificUser = users.firstWhere(
          (usuario) => usuario.email == email ,
      orElse: () => Usuario(nombre: "nombre", contrasena: "contrasena", telefono: 0, email: email, likes: [], matches: [], chats: []),
    );

    return specificUser;
  }


}
