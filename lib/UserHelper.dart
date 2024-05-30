import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'Usuario.dart'; // Asegúrate de importar tu clase User

class UserHelper {

  static Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/users.json');
  }

  static Future<bool> existsUser(String email) async {
    List<Usuario> users = await getUsers();
    return users.any((user) => user.email == email);
  }

  static Future<Usuario?> getUserByMailAndPassword(String email, String password) async {
    List<Usuario> users = await getUsers();
    try {
      return users.firstWhere(
            (user) => user.email == email && user.contrasena == password,
      );
    } catch (e) {
      return null; // Retorna null si no encuentra un usuario
    }
  }

  static Future<bool> saveUser(Usuario user) async {
    try {
      final file = await _getFile();
      List<Usuario> users = await getUsers();
      // Verifica si el usuario ya existe en la lista
      int index = users.indexWhere((u) => u.email == user.email);
      if (index != -1) {
        // Si el usuario ya existe, actualiza sus datos
        users[index] = user;
      } else {
        // Si el usuario no existe, añádelo a la lista
        users.add(user);
      }
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

  static Future<List<Usuario>> getUsersFromAssets() async {
    try {
      final jsonString = await rootBundle.loadString('assets/users.json');
      final List<dynamic> userMaps = jsonDecode(jsonString);
      return userMaps.map((userMap) => Usuario.fromJson(userMap)).toList();
    } catch (e) {
      return [];
    }
  }

  static void openJsonFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/users.json');
    if (await file.exists()) {
      String content = await file.readAsString();
      List<dynamic> jsonContent = jsonDecode(content);
      print(jsonContent);
    } else {
      print('El archivo no existe');
    }
  }

  static void saveSpecificUser(Usuario user) async {
    List<Usuario> users = await UserHelper.getUsers();
    users.removeWhere((element) => element.email == user.email);
    users.add(user);
    UserHelper.saveAllUsers(users);
  }

  static void printAllUsers() async {
    List<Usuario> users = await UserHelper.getUsers();
    users.forEach((user) {
      print(user.toString());
    });
  }

  static Future<Usuario?> getSpecificUser(String email) async {
    List<Usuario> users = await UserHelper.getUsers();

    try {
      return users.firstWhere((usuario) => usuario.email == email);
    } catch (e) {
      return null; // Retorna null si no encuentra un usuario
    }
  }

  static Future<bool> saveAllUsers(List<Usuario> users) async {
    try {
      final file = await _getFile();
      final jsonString = jsonEncode(users.map((user) => user.toJson()).toList());
      await file.writeAsString(jsonString);
      return true;
    } catch (e) {
      return false;
    }
  }
}
